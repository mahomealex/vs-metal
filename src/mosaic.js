{
    "variables":{
        "mymosaic":{
            "type":"sin",
            "range":[1.0, 120.0],
            "interval":2.0
        }
    },
    "pipeline":[{
        "name":"mosaic",
        "attr":{
            "size": "mymosaic",
        }
    }]
}
