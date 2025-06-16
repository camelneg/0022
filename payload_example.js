/*
              ___                           
  ___  _ __  |   \ ___ __ _ _ __  ___ _ _  
 / _ \| '  \ | |) / -_) _` | '  \/ -_) '_| 
 \___/|_|_|_||___/\___\__,_|_|_|_\___|_|   
      Payload Demo - by apologygirl0       
      Action: Lancer calc.exe Windows       
*/

var shell = new ActiveXObject("WScript.Shell");
shell.Run("calc.exe", 0, false);  // 0 = cache la fenêtre cmd
