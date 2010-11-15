open Types

let create host ?(https=false) login private_key = 
  {
    host = host; 
    https = https; 

    login = login ; 
    private_key = private_key ;
  }
