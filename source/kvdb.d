// Copyright (c) 2018 CVSC
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

import std.conv : to;
import std.stdio;
import std.file;
import std.json;



/**
 * kvdb
 */
class kvdb
{
	JSONValue j;
	string dbdata;
	string db;	

	this(string dbfile){
		db = dbfile;
	    // :dbfile database filename
	    if(exists(dbfile))
	    	// already have dbfile load it 
	    	load();
		else
	    	// db not exists, init null db
	    	j = parseJSON("{}");
	}


	void load(){
		// load db contents
		File file = File(db, "r");
	    j = parseJSON(file.readln());
	}




	void save()
	{
		// save 
		File file = File(db, "w+");
		file.write(j);
		file.close();
		load(); // load with the new objects
	}




	bool set(string key, string value){
		if(!havekey(key))
		{
			j.object[key] = value;
        	save();
        	return true;
		}

		return false;
	}


	bool update(string key, string value)
	{
		if(havekey(key))
		{
			j.object[key] = value;
        	save();
        	return true;
		}

		return false;
	}


	string[] getkeys()
	{
		// get keys 
		return(j.object.keys);
	}


	string get(string key){
		// return the value of specifiec key
		if(havekey(key)) {
			return j[key].str;
		}

		return "";
	}



	int countkeys()
	{
		// return the lenght of database keys
		return to!int(j.object.keys.length);
	}

	bool havekey(string key)
	{
		// return true if key exists false if not
		return((key in j) != null);
	}

	void drop()
	{
		// Drop database
		if(exists(db))
			remove(db);
		else 
			throw new Exception("Error: Unable to drop a non-existing database");
	}

	int getsize() {
		// return database size in bytes
		if(exists(db))
			return to!int(getSize(db));
		else
			throw new Exception("Error: Unable to get database size, database does not exists.");
	}
}