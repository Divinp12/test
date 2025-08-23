use std::process::{Command, Stdio};

fn main() {

        println!("adicionando espelho brasileiro");

        let status1 = Command::new("sh")
            .arg("-c")
            .arg("echo 'Server=https://mirror.ufscar.br/archlinux/\\$repo/os/\\$arch' > /etc/pacman.d/mirrorlist")
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .status()
            .expect("algo deu errado ao executar comando de adicionar espelho brasileiro");

               if status1.success() {
                  println!("sucesso");
                     let _ = Command::new("clear").status();}

        
        println!("adicionando espelho brasileiro");
        
        let status1 = Command::new("sh")
            .arg("-c")
            .arg("echo 'Server=https://mirror.ufscar.br/archlinux/\\$repo/os/\\$arch' > /etc/pacman.d/mirrorlist")
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .status()
            .expect("algo deu errado ao executar comando de adicionar espelho brasileiro");

               if status1.success() {
                  println!("sucesso");
                     let _ = Command::new("clear").status();}
        
        else {
        eprintln!("falha na atualização");
    }
}
