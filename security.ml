open Misc
open Types

let sign connection meth params =
  let req = List.fold_left (fun acc (k,v) -> Printf.sprintf "%s%s=%s" acc k v) meth params in
   
  let hasher = Cryptokit.Hash.sha256 () in
  let encoder = Cryptokit.Hexa.encode () in

  Printf.printf "@@@ Corefarmreq : %s\n" req ; flush stdout; 
    Cryptokit.hash_string hasher (req ^ connection.login  ^ connection.private_key ) >>> 
      Cryptokit.transform_string encoder >>> 
      String.lowercase 
