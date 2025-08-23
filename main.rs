use std::process::{Command, Stdio};

fn main() {

        let status1 = Command::new("echo")
            .arg("'Server=https://mirror.ufscar.br/archlinux/\$repo/os/\$arch'")
            .arg(">")
            .arg("/etc/pacman.d/mirrorlist")
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .status()
            .expect("Falha ao executar o comando");

               if status1.success() {
                  println!("atualização concluída");
                     let _ = Command::new("clear").status();}



    
    println!("atualizando repositórios");
    
        let status3 = Command::new("pacman")
        .arg("-Sy")
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .expect("Falha ao executar o comando");

    if status3.success() {
        println!("atualização concluída");
        let _ = Command::new("clear").status();
}
        
        else {
        eprintln!("falha na atualização");
    }
}
