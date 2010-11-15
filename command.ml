open Lwt 

open Misc
open Types

let soi = string_of_int 
let sof = string_of_float 

exception Error_extraction 

let build_get_handler connection meth params = 

  let encoded_params = List.map (fun (k,v) -> (encode k), (encode v)) params in
  let signature = Security.sign connection meth params >>> encode in
    
  let uri = List.fold_left (fun acc (k,v) -> Printf.sprintf "%s&%s=%s" acc k v) (Printf.sprintf "%s?signature=%s&login=%s" meth signature (encode connection.login)) encoded_params in
    
    Ocsigen_http_client.get 
      ~https:connection.https
      ~host:connection.host
      ~uri () >>= fun frame -> 
	match frame.Ocsigen_http_frame.content with  (* Doc is out-of-date? *)
	    None -> return "" 
	  | Some stream -> Ocsigen_stream.get stream >>> Ocsigen_stream.string_of_stream

let extract_int label json = 
  match Json_io.json_of_string json with 
      Json_type.Object ol -> 
	(match List.assoc label ol with 
	     Json_type.Int v -> v
	   | _ -> raise Error_extraction) 
    | _ -> raise Error_extraction 

let extract_string label json = 
  match Json_io.json_of_string json with 
      Json_type.Object ol -> 
	(match List.assoc label ol with 
	     Json_type.String v -> v
	   | Json_type.Int v -> string_of_int v
	   | _ -> raise Error_extraction) 
    | _ -> raise Error_extraction 

let new_job connection application = 
  
  [ "application", application; 
    "date", sof (Unix.time ()); 
    "isconfidential", "true" ] >>> 
    build_get_handler connection "new_job" 
    
    
let start_job connection job_id ghz input = 
  
  [ "date", sof (Unix.time ()) ; 
    "ghz", soi ghz ;
    "input", input ; 
    "job_id", job_id ] >>> build_get_handler connection "start_job"
    
let stop_job connection job_id = 
  
  [
    "date", sof (Unix.time ()) ; 
    "job_id", job_id ] >>> build_get_handler connection "stop_job"


let get_store_dir connection job_id = 
  
  [
    "date", sof (Unix.time ()) ; 
    "job_id", job_id ;
    "login", connection.login ] >>> build_get_handler connection "get_store_dir" 


let drop_file connection bucket file = 
  () 
