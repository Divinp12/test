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



println!("atualizando repositorios");
let status3 = Command::new("pacman")
.arg("-Sy")
.arg("--noconfirm")
.arg("--quiet")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao executar comando de atualizar repositorios");
if status3.success() {
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



println!("formatando 1 disco rigido valido");
let status4 = Command::new("sh")
.arg("-c")
.arg("if dd if=/dev/zero of=/dev/nvme0n1p bs=64M")
.arg("&&")
.arg("parted /dev/nvme0n1p mklabel gpt")
.arg("&&")
.arg("parted /dev/nvme0n1p mkpart ESP fat32 1MiB 1025MiB")
.arg("&&")
.arg("parted /dev/nvme0n1p set 1 esp on")
.arg("&&")
.arg("parted /dev/nvme0n1p mkpart primary ext4 1025MiB 30721MiB")
.arg("&&")
.arg("parted /dev/nvme0n1p mkpart primary ext4 30721MiB 100%")
.arg("&&")
.arg("partprobe")
.arg("&&")
.arg("mkfs.fat -F32 /dev/nvme0n1p1")
.arg("&&")
.arg("mkfs.ext4 -F /dev/nvme0n1p2")
.arg("&&")
.arg("mkfs.ext4 -F /dev/nvme0n1p3")
.arg("&&")
.arg("mount /dev/nvme0n1p2 /mnt")
.arg("&&")
.arg("mkdir /mnt/boot")
.arg("&&")
.arg("mkdir /mnt/boot/EFI")
.arg("&&")
.arg("mkdir /mnt/home")
.arg("&&")
.arg("mount /dev/nvme0n1p1 /mnt/boot/EFI")
.arg("&&")
.arg("mount /dev/nvme0n1p3 /mnt/home
else")
.arg("dd if=/dev/zero of=/dev/sda bs=64M")
.arg("&&")
.arg("parted /dev/sda mklabel gpt")
.arg("&&")
.arg("parted /dev/sda mkpart ESP fat32 1MiB 1025MiB")
.arg("&&")
.arg("parted /dev/sda set 1 esp on")
.arg("&&")
.arg("parted /dev/sda mkpart primary ext4 1025MiB 30721MiB")
.arg("&&")
.arg("parted /dev/sda mkpart primary ext4 30721MiB 100%")
.arg("&&")
.arg("partprobe")
.arg("&&")
.arg("mkfs.fat -F32 /dev/sda1")
.arg("&&")
.arg("mkfs.ext4 -F /dev/sda2")
.arg("&&")
.arg("mkfs.ext4 -F /dev/sda3")
.arg("&&")
.arg("mount /dev/sda2 /mnt")
.arg("&&")
.arg("mkdir /mnt/boot")
.arg("&&")
.arg("mkdir /mnt/boot/EFI")
.arg("&&")
.arg("mkdir /mnt/home")
.arg("&&")
.arg("mount /dev/sda1 /mnt/boot/EFI")
.arg("&&")
.arg("mount /dev/sda3 /mnt/home
fi")
.stdout(Stdio::null())
.stderr(Stdio::null())
.status()
.expect("algo deu errado ao executar comando de formatar 1 disco rigido valido");
if status4.success() {
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
