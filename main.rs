use std::process::{Command, Stdio};

fn main() {
    let status = Command::new("pacman")
        .arg("-Syu")
        .arg("--noconfirm")
        .arg("--quiet")
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .expect("Falha ao executar o comando");

    if status.success() {
        println!("Atualização concluída com sucesso!");
    } else {
        eprintln!("Falha na atualização.");
    }
}
