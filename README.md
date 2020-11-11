# kvdb
[![Build Status](https://travis-ci.org/cvsae/kvdb.svg?branch=master)](https://travis-ci.org/cvsae/kvdb)

 kvdb is lightweight and simple key-value dlang database (store) build on top of std.json 

## Usage


``` d


import std.stdio;
import kvdb;

void main()
{  
    // use false for in memory data sore 
    kvdb db = new kvdb(false);
    
    // use file path for disk data store 
    kvdb db = new kvdb("test.db");
    

    // assign to hello key the value world 
    db.set("hello", "world");
    // read value for key hello
    string value = db.get("hello")
    // print value of hello key 
    writeln(value);
    // world
    
    
    // update hello key value from world to goodbye
    db.update("hello", "goodbye");
    // read value for key hello
    string value_updated = db.get("hello")
    // print value of hello key 
    writeln(value_updated);
    // goodbye
    
    // lookup if key exists
    bool havekey = db.havekey("hello");
    
    if (havekey)
       writeln("key exists")
    else{
       writeln("key not exists")
       }

    writeln(db.getsize());
    // db.getsize() return the database size in bytes
    
    
    // db.drop() delete database 
    // NOTE: all db data will be lost
    db.drop();
}


v0.0.2 (2017-11-11)
===================

- Added store method -> In memory data store option



    
v0.0.1 (2020-10-6)
===================

- First official release – consider kvdb stable now.
