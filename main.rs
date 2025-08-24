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
.arg(r#"if dd if=/dev/zero of=/dev/nvme0n1p bs=64M && \
parted /dev/nvme0n1p mklabel gpt && \
parted /dev/nvme0n1p mkpart ESP fat32 1MiB 1025MiB && \
parted /dev/nvme0n1p set 1 esp on && \
parted /dev/nvme0n1p mkpart primary ext4 1025MiB 30721MiB && \
parted /dev/nvme0n1p mkpart primary ext4 30721MiB 100% && \
partprobe && \
mkfs.fat -F32 /dev/nvme0n1p1 && \
mkfs.ext4 -F /dev/nvme0n1p2 && \
mkfs.ext4 -F /dev/nvme0n1p3 && \
mount /dev/nvme0n1p2 /mnt && \
mkdir /mnt/boot && \
mkdir /mnt/boot/EFI && \
mkdir /mnt/home && \
mount /dev/nvme0n1p1 /mnt/boot/EFI && \
mount /dev/nvme0n1p3 /mnt/home
else
dd if=/dev/zero of=/dev/sda bs=64M && \
parted /dev/sda mklabel gpt && \
parted /dev/sda mkpart ESP fat32 1MiB 1025MiB && \
parted /dev/sda set 1 esp on && \
parted /dev/sda mkpart primary ext4 1025MiB 30721MiB && \
parted /dev/sda mkpart primary ext4 30721MiB 100% && \
partprobe && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 -F /dev/sda2 && \
mkfs.ext4 -F /dev/sda3 && \
mount /dev/sda2 /mnt && \
mkdir /mnt/boot && \
mkdir /mnt/boot/EFI && \
mkdir /mnt/home && \
mount /dev/sda1 /mnt/boot/EFI && \
mount /dev/sda3 /mnt/home
fi"#)
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
