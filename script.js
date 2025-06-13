const { exec } = require('child_process');

exec('calc.exe', (error, stdout, stderr) => {
  if (error) {
    console.error(`Erreur : ${error.message}`);
    return;
  }
  if (stderr) {
    console.error(`Stderr : ${stderr}`);
    return;
  }
  console.log(`Sortie : ${stdout}`);
});
