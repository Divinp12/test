use std::process::{Command, Stdio};
use std::thread;
use std::time::Duration;


// atalhos para facilita

fn pausa_e_limpar ()       { 
                             thread::sleep(Duration::from_secs(3)); // pausa em 3 segundos. Para muda a duracao da pausa altere o numero depois de from_secs(
                             let _ = Command::new("clear")
                             .status();
                           }

fn sem_mensagem_e_input () {
                             .stdout(Stdio::null())                 // redirecionar mensagens para lugar nenhum.
                             .stderr(Stdio::null())                 // redirecionar mensagens de erro para lugar nenhum.
                             .stdin(Stdio::null())                  // redirecionar input de teclado, mouse, etc para lugar nenhum.
                           }


// executa formatacao
  
fn main() {


println!("adicionando espelho brasileiro");
let status1 = Command::new("sh")
.arg("-c")
.arg(r#"echo 'Server=https://mirror.ufscar.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar espelho brasileiro");
if status1.success() {
println!("sucesso");
pausa_e_limpar ();
}

  
println!("sobscrevendo arquivo pacman.conf");
let status2 = Command::new("sh")
.arg("-c")
.arg(r#"echo '[options]
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
Include=/etc/pacman.d/mirrorlist' > /etc/pacman.conf"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao sobscrever arquivo pacman.conf");
if status2.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("atualizando repositorios");
let status3 = Command::new("pacman")
.arg("-Sy")
.arg("--noconfirm")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao atualizar repositorios");
if status3.success() {
println!("sucesso");
pausa_e_limpar ();
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
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao formatar 1 disco rigido valido");
if status4.success() {
println!("sucesso");
pausa_e_limpar ();
}



println!("instalando pacotes do sistema");
let status5 = Command::new("pacstrap")
.arg("/mnt")
.arg("--noconfirm")
.arg("base")
.arg("base-devel")
.arg("linux")
.arg("linux-firmware")
.arg("linux-headers")
.arg("networkmanager")
.arg("sudo")
.arg("git")
.arg("fastfetch")
.arg("mesa")
.arg("plasma")
.arg("wayland")
.arg("lib32-wayland")
.arg("xorg-xwayland")
.arg("foot")
.arg("pulseaudio")
.arg("pavucontrol")
.arg("grub-efi-x86_64")
.arg("efibootmgr")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao instalar pacotes do sistema");
if status5.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("configurando partições no arquivo fstab");
let status6 = Command::new("sh")
.arg("-c")
.arg("genfstab -U -p /mnt > /mnt/etc/fstab")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao instalar pacotes do sistema");
if status6.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando nome bux ao usuario root no arquivo hostname");
let status7 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo bux > /etc/hostname"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar nome bux ao usuario root no arquivo hostname");
if status7.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando senha bux ao usuario root");
let status8 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo -e 'bux\nbux' | passwd root"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar senha bux ao usuario root");
if status8.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando usuario normal com nome bux");
let status9 = Command::new("arch-chroot")
.arg("/mnt")
.arg("useradd")
.arg("-m")
.arg("-g")
.arg("users")
.arg("-G")
.arg("wheel")
.arg("bux")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar usuario normal com nome bux");
if status9.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando senha bux ao usuario normal");
let status10 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo -e 'bux\nbux' | passwd bux"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar senha bux ao usuario normal");
if status10.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando caracteres portugues brasileiro");
let status11 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo 'pt_BR.UTF-8 UTF-8' > /etc/locale.gen"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar caracteres portugues brasileiro");
if status11.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando idioma portugues brasileiro");
let status12 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar caracteres portugues brasileiro");
if status12.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("aplicando caracteres portugues brasileiro");
let status13 = Command::new("arch-chroot")
.arg("/mnt")
.arg("locale-gen")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao aplicar caracteres portugues brasileiro");
if status13.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("sincronizando relogio");
let status14 = Command::new("arch-chroot")
.arg("/mnt")
.arg("hwclock")
.arg("--systohc")
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao sincronizar relogio");
if status14.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("adicionando espelho brasileiro");
let status15 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo 'Server=https://mirror.ufscar.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar espelho brasileiro");
if status15.success() {
println!("sucesso");
pausa_e_limpar ();
}


println!("sobscrevendo arquivo .bashrc");
let status16 = Command::new("arch-chroot")
.arg("/mnt")
.arg("sh")
.arg("-c")
.arg(r#"echo 'alias i=\"paru -Sy --noconfirm --quiet\";
alias d=\"sudo pacman -Rsc\";
alias a=\"paru -Syyu --noconfirm --quiet\";
alias m=\"pacman -Q\";
alias w=\"nmtui\";
sudo rm -rf /home/bux/.bash_history;
sudo pacman -Scc --noconfirm --quiet;
clear;
sudo sleep 1;
fastfetch;
echo \"
INFORMAÇÕES DE PACOTES:
INSTALAR PACOTES (i nome-do-pacote)
DESISTALAR PACOTES (d nome-do-pacote)
ATUALIZAR PACOTES (a nome-do-pacote ou apenas a para todos)
MOSTRA PACOTES INSTALADOS (m nome-do-pacote ou apenas m para todos)
EXEMPLO: i google-chrome

INFORMAÇÕES DE DRIVERS:
CONECTAR A REDE WIFI COM OU SEM FIO (w)
\";
git clone https://aur.archlinux.org/paru.git && \\
chmod 777 paru && \\
cd paru && \\
makepkg -si --noconfirm --quiet && \\
cd .. && \\
sudo rm -rf paru && \\
paru -Sy --noconfirm --quiet nano && \\
sudo sed -i \"22,\\\$d\" /home/bux/.bashrc' > /home/bux/.bashrc"#)
sem_mensagem_e_input ();
.status()
.expect("algo deu errado ao adicionar espelho brasileiro");
if status16.success() {
println!("sucesso");
pausa_e_limpar ();
}
  
        else {
        eprintln!("falha na atualização");
    }
}
