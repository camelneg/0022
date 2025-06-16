// payload.js – Exécution de calc.exe via Node.js
// ----------------------------------------------
// Ce script est exécuté via le dropper, il déclenche l'ouverture de la calculette.

const { exec } = require("child_process");

exec("calc.exe", (error, stdout, stderr) => {
  if (error) {
    console.error(`[!] Erreur : ${error.message}`);
    return;
  }
  if (stderr) {
    console.error(`[!] Stderr : ${stderr}`);
    return;
  }
  console.log(`[+] Résultat : ${stdout}`);
});
