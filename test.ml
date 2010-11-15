let (>>>) f g = g f 

let _ = 
  let req = "application=yafaraydate=1289750853isconfidential=truesvetlyak.40wt@gmail.comdzwGO2zV8G" in
  let req = "blah" in 
  let hasher = Cryptokit.Hash.sha256 () in
  let encoder = Cryptokit.Hexa.encode () in

  let hash =  Cryptokit.hash_string hasher req >>> 
    Cryptokit.transform_string encoder >>> 
    String.lowercase in 
  Printf.printf "Hash: %s\n" hash ; 
  Printf.printf "Hash size : %d\n" (String.length hash)

