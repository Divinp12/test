use std::process::{Command, Stdio};
use std::thread;
use std::time::Duration;

// thread::sleep(Duration::from_secs(3)); // pausa em 3 segundos. Para muda a duracao da pausa altere o numero depois de from_secs(
// let _ = Command::new("clear")
// .status();

// .stdout(Stdio::null()) redirecionar mensagens para lugar nenhum.
// .stderr(Stdio::null()) redirecionar mensagens de erro para lugar nenhum.
// .stdin(Stdio::null())  redirecionar input de teclado, mouse, etc para lugar nenhum.


// executa formatacao
  
fn main() {


println!("formatando 1 disco rigido valido");
let status1 = Command::new("sh")
.arg("-c")
.arg(r#"if dd if=/dev/zero of=/dev/nvme0n1p bs=64M && \
parted -s /dev/nvme0n1p mklabel gpt && \
parted -s /dev/nvme0n1p mkpart ESP fat32 1MiB 1000MiB && \
parted -s /dev/nvme0n1p set 1 esp on && \
parted -s /dev/nvme0n1p mkpart primary ext4 1000MiB 30000MiB && \
parted -s /dev/nvme0n1p mkpart primary ext4 30000MiB 100% && \
mkfs.fat -F32 /dev/nvme0n1p1 && \
mkfs.ext4 -F /dev/nvme0n1p2 && \
mkfs.ext4 -F /dev/nvme0n1p3 && \
mount /dev/nvme0n1p2 /mnt/gentoo && \
mkdir /mnt/gentoo/boot && \
mount /dev/nvme0n1p1 /mnt/gentoo/boot && \
mkdir /mnt/gentoo/home && \
mount /dev/nvme0n1p3 /mnt/gentoo/home
else
dd if=/dev/zero of=/dev/sda bs=64M && \
parted -s /dev/sda mklabel gpt && \
parted -s /dev/sda mkpart ESP fat32 1MiB 1000MiB && \
parted -s /dev/sda set 1 esp on && \
parted -s /dev/sda mkpart primary ext4 1000MiB 30000MiB && \
parted -s /dev/sda mkpart primary ext4 30000MiB 100% && \
mkfs.fat -F32 /dev/sda1 && \
mkfs.ext4 -F /dev/sda2 && \
mkfs.ext4 -F /dev/sda3 && \
mount /dev/sda2 /mnt/gentoo && \
mkdir /mnt/gentoo/boot && \
mount /dev/sda1 /mnt/gentoo/boot && \
mkdir /mnt/gentoo/home && \
mount /dev/sda3 /mnt/gentoo/home
fi"#)
.stdout(Stdio::null())
.stderr(Stdio::null())
.stdin(Stdio::null())
.status();
match status1 {
Ok(status) if status.success() => {println!("sucesso");thread::sleep(Duration::from_secs(3));let _ = Command::new("clear").status();}
Ok(_) => {println!("falha ao formata 1 disco rigido valido");}
Err(e) => {eprintln!("erro ao executar o comando: {}", e);}
}


println!("baixando stage3");
let status2 = Command::new("wget")
.arg("-P")
.arg("/mnt/gentoo")
.arg("https://distfiles.gentoo.org/releases/amd64/autobuilds/20250907T165007Z/stage3-amd64-openrc-20250907T165007Z.tar.xz")
.stdout(Stdio::null())
.stderr(Stdio::null())
.stdin(Stdio::null())
.status();
match status2 {
Ok(status) if status.success() => {println!("sucesso");thread::sleep(Duration::from_secs(3));let _ = Command::new("clear").status();}
Ok(_) => {println!("falha ao baixa stage3");}
Err(e) => {eprintln!("erro ao executar o comando: {}", e);}
}


println!("descompactando stage3");
let status3 = Command::new("tar")
.arg("xvpf")
.arg("stage3-amd64-openrc-20250907T165007Z.tar.xz")
.arg("--xattrs")
.arg("--numeric-owner")
.stdout(Stdio::null())
.stderr(Stdio::null())
.stdin(Stdio::null())
.status();
match status3 {
Ok(status) if status.success() => {println!("sucesso");thread::sleep(Duration::from_secs(3));let _ = Command::new("clear").status();}
Ok(_) => {println!("falha ao descompacta stage3");}
Err(e) => {eprintln!("erro ao executar o comando: {}", e);}
}
