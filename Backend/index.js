var cheerio = require('cheerio'),
    express = require('express'),
    request = require('request'),
    redis = require('redis'),
    schedule = require('node-schedule'),
    axios = require('axios');

//Scheduler functions to refresh redis cache every 24 hours, using the CRON scheduling system.
// schedule.scheduleJob('* * 23 * * *', topMoviesList());

//Express app 
var app = express();

//Redis initialization
var host = '127.0.0.1';
var port = 6379;
var client = redis.createClient(port,host);

var moviesJson={};
var showJson = {};
var topMoviesJson = {};
var popShowJson = {};

client.on('connect', function(){
    console.log('Redis connected');
});

client.on('error', function(err){
    console.log(err)
})

// Redis refresh functions 
function topMoviesList(){
    request("http://www.levidia.ch/levidia?v=movies", function(err,res,body){
        if(err){
            topMoviesList();
        }
        if(body){    
            $ = cheerio.load(body);
            
            links = $('a'); //jquery get all hyperlinks

            $(links).each(function(i, link){
                if(i>=11 && i<=60){
                    request($(link).attr('href'), function(err,res,body){
                        if(err){
                            topMoviesList();
                        }
                        if(body){   
                             topMoviesJson[$(link).text()] = {
                                movie: $(link).text(),
                                link: $(link).attr('href'),
                                img: cheerio.load(body)('.mposter').attr('src')
                             }
                        }
                    // }); 
                });
            }
        });

    var timeOut = 90000;
        setTimeout(()=>{
            client.set('top-movies-list', JSON.stringify(topMoviesJson), redis.print);
        }, timeOut)
    }
});
}

function topShowList() {
    request("http://www.levidia.ch/levidia?v=episodes", function(err,res,body){
        if(err){
            topShowList();
        }
        if(body){    
            $ = cheerio.load(body);
            
            links = $('a'); //jquery get all hyperlinks
            pattern = / \(Season /;
            
            $(links).each(function(i, link){
                if(i>=11 && i<=60){
                    var data = $(link).text().match(pattern);
                    var pos = data.index;
                    var str = data.input; 
                    var Name = str.slice(0,pos);
                    var str_second = str.slice(pos+2,str.length-1)

                    var comma_index = str_second.match(',').index;
                    var Season_no = str_second.slice(comma_index-1,comma_index);
                    var Episode = str_second.slice(comma_index+1,str_second.length)

                    request($(link).attr('href'), function(err,res,body){
                        if(err){
                            topShowList();
                        }
                        if(body){    
                            showJson[str] = { 
                                fullName : str,
                                show: Name,
                                season: 'Season '+Season_no,
                                episode : Episode,
                                link : $(link).attr('href'),
                                img : cheerio.load(body)('.mposter').attr('src')
                            }
                        }

                    }); 
                }
            });
        }
    });  
    var timeOut = 90000;
    setTimeout(()=>{
        client.set('top-show-list', JSON.stringify(showJson), redis.print);
    }, timeOut)  
}

function popularMoviesList() {
    for(i=2;i<=10;i++){
        request("http://www.levidia.ch/?tab=top&v=movies&page="+i, function(err,res,body){
            if(err){
                popularMoviesList();
            }
            if(body){    
                $ = cheerio.load(body);
                
                links = $('a'); //jquery get all hyperlinks

                    $(links).each(function(i, link){
                        if(i>=11 && i<=60){
                            request($(link).attr('href'), function(err,res,body){
                                    if(err){
                                        popularMoviesList();
                                    }
                                    if(body){    
                                        moviesJson[$(link).text()] = {
                                            movie: $(link).text(),
                                            link: $(link).attr('href'),
                                            img: cheerio.load(body)('.mposter').attr('src')
                                        }
                                    }
                            }); 
                        }
                    })
                }
                
        }); 
    } 
    
    var timeOut = 250000;
                setTimeout(()=>{
                    client.set('popular-movies-list', JSON.stringify(moviesJson), redis.print);
                }, timeOut)
}

function popularShowList(){
     
    for(i=2;i<=10;i++){
        request("http://www.levidia.ch/?tab=top&v=episodes&page="+i, function(err,res,body){
        
        if(err){
            popularShowList();
        }

        if(body && body!=undefined){
            $ = cheerio.load(body);
        
            links = $('a'); //jquery get all hyperlinks
            pattern = / \(Season /;
            
                $(links).each(function(i, link){
                    if(i>=11 && i<=60){
                        var data = $(link).text().match(pattern);
                        var pos = data.index;
                        var str = data.input; 
                        var Name = str.slice(0,pos);
                        var str_second = str.slice(pos+2,str.length-1)

                        var comma_index = str_second.match(',').index;
                        var Season_no = str_second.slice(comma_index-1,comma_index);
                        var Episode = str_second.slice(comma_index+1,str_second.length)

                            request($(link).attr('href'), function(err,res,body){
                                if(err){
                                    popularShowList();
                                }
                                if(body)
                                {    popShowJson[str] = { 
                                        fullName : str,
                                        show: Name,
                                        season: 'Season '+Season_no,
                                        episode : Episode,
                                        link : $(link).attr('href'),
                                        img : cheerio.load(body)('.mposter').attr('src')
                                    }
                                }

                            }); 
                    }
                });
            }
        });
    }
    var timeOut = 100000;
            setTimeout(()=>{
                client.set('popular-show-list', JSON.stringify(popShowJson), redis.print);
            }, timeOut)    
}

function getImg(json){
    for(i in json){
        console.log(i)
    }
}

//Open APIs 
//To get list of trending movies
app.get('/top-movies',function(req,res){
    setTimeout(()=>{
        client.get('top-movies-list', function(err,topMovies){
            if(err){
                console.log(err);
                throw err;
            }
            res.status(200).send(JSON.parse(topMovies))
        })
    }, 100)
})

//To get a list of trending shows
app.get('/top-shows',function(req,res){
    setTimeout(()=>{
        client.get('top-show-list', function(err, topShows){
            if(err){
                console.log(err)
                throw err;
            }
            res.status(200).send(JSON.parse(topShows))
        })
    },10)
});

//To get a list of popular shows 
app.get('/pop-shows', function(req,res){
    setTimeout(()=>{
        client.get('popular-show-list', function(err, popShows){
            if(err){
                console.log(err)
                throw err;
            }
            res.status(200).send(JSON.parse(popShows))
        })
    },100)
})

app.get('/pop-movies', function(req,res){
    setTimeout(()=>{
        client.get('popular-movies-list', function(err, popMovies){
            if(err){
                console.log(err)
            }
            // res.status(200).send(JSON.parse(popMovies));
            if(popMovies){
                popMovies = JSON.parse(popMovies)
                for(key in popMovies){
                    if(popMovies[key]['img']==undefined){
                        delete popMovies[key];
                    }
                }
                res.status(200).send(popMovies);
            }
        })
    },100)
})

//Run server
app.listen(9000, ()=>{
    console.log('Running on port 9000');
})

