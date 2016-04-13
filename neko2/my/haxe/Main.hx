package my.haxe;

import neko.Lib;
import sys.db.Sqlite as Sqlite;
import sys.db.Manager as DBManager;

/**
 * ...
 * @author 
 */
class Main 
{

	static function main() 
	{
		
        var cnx = Sqlite.open("g:/temp/user1.db");
        // ...
		
		DBManager.cnx = cnx;
        DBManager.initialize();
        // run the application
        execute();
        // close the connection and do some cleanup
        DBManager.cleanup();
		
        cnx.close();
    
	}
	
	static function execute() {
        var u = User.manager.get(5); // get user #5
        if( u == null ) {
            u = new User();
            u.id = 5; // force the id to 5
            u.name = "John";
            u.age = 1;
            u.insert();
        } else {
            u.age++;
            u.update();
        }
        trace(u.name+" is "+u.age+" years old");
    }	
	
}

class User extends sys.db.Object {
    public var id : Int;
    public var name : String;
    public var age : Int;
    
    public static var manager = new sys.db.Manager<User>(User);
}