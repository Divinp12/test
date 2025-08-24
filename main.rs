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
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}



println!("sobscrevendo arquivo pacman.conf");
let status2 = Command::new("sh")
.arg("-c")
.arg("echo '[options]
Architecture=auto
CheckSpace
ParallelDownloads=1
SigLevel=Required DatabaseOptional
LocalFileSigLevel=Optional
[core]
Include=/etc/pacman.d/mirrorlist
[extra]
Include=/etc/pacman.d/mirrorlist
[multilib]
Include=/etc/pacman.d/mirrorlist' > /etc/pacman.conf")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao executar comando de sobscrever arquivo pacman.conf");
if status2.success() {
println!("sucesso");
let _ = Command::new("sleep")
.arg("3")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
let _ = Command::new("clear")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status();
}
        
        else {
        eprintln!("falha na atualização");
    }
}
