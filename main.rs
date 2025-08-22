use std::process::{Command, Stdio};

fn main() {
    println!("Atualizando repositórios...");
    
    let status = Command::new("pacman")
        .arg("-Sy")
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .expect("Falha ao executar o comando");

    if status.success() {
        println!("Atualização concluída");
    } else {
        eprintln!("Falha na atualização.");
    }
}
