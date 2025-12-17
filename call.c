/*
 Projeto: chamada_voz_simples
 Plataforma: Linux (somente terminal)
 Linguagem: C

 Caracteristicas atendidas:
 - Apenas Linux
 - Sem interface grafica (terminal puro)
 - Interacao apenas por comandos (stdin)
 - Audio mono
 - Sem criptografia
 - Sem compressao
 - Sem controle de perda de pacotes
 - Uso exclusivo de RAM (streaming direto)
 - Minimo de dependencias
 - Otimizado para maquinas antigas

 Dependencias externas:
 - ALSA (libasound) para captura e reproducao de audio
 - Sockets POSIX (padrao do Linux)

 Compilacao:
 gcc chamada_voz.c -o chamada_voz -lasound

 Uso:
 Servidor (escuta): ./chamada_voz server <porta>
 Cliente (chama):   ./chamada_voz client <ip> <porta>
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <alsa/asoundlib.h>

#define SAMPLE_RATE 8000          /* Baixa taxa para maquinas antigas */
#define CHANNELS 1                /* Mono */
#define FRAMES 160                /* 20ms @ 8kHz */

static snd_pcm_t *capture_handle;
static snd_pcm_t *playback_handle;

void audio_init_capture() {
    snd_pcm_open(&capture_handle, "default", SND_PCM_STREAM_CAPTURE, 0);
    snd_pcm_set_params(capture_handle,
                       SND_PCM_FORMAT_S16_LE,
                       SND_PCM_ACCESS_RW_INTERLEAVED,
                       CHANNELS,
                       SAMPLE_RATE,
                       1,
                       500000);
}

void audio_init_playback() {
    snd_pcm_open(&playback_handle, "default", SND_PCM_STREAM_PLAYBACK, 0);
    snd_pcm_set_params(playback_handle,
                       SND_PCM_FORMAT_S16_LE,
                       SND_PCM_ACCESS_RW_INTERLEAVED,
                       CHANNELS,
                       SAMPLE_RATE,
                       1,
                       500000);
}

int main(int argc, char *argv[]) {
    int sock;
    struct sockaddr_in addr;
    short buffer[FRAMES];

    if (argc < 3) {
        printf("Uso:\n server <porta>\n client <ip> <porta>\n");
        return 1;
    }

    audio_init_capture();
    audio_init_playback();

    sock = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(atoi(argv[argc-1]));

    if (strcmp(argv[1], "server") == 0) {
        addr.sin_addr.s_addr = INADDR_ANY;
        bind(sock, (struct sockaddr*)&addr, sizeof(addr));
        printf("Servidor escutando...\n");

        while (1) {
            recv(sock, buffer, sizeof(buffer), 0);
            snd_pcm_writei(playback_handle, buffer, FRAMES);
        }
    }

    if (strcmp(argv[1], "client") == 0) {
        inet_pton(AF_INET, argv[2], &addr.sin_addr);
        printf("Chamando %s...\n", argv[2]);

        while (1) {
            snd_pcm_readi(capture_handle, buffer, FRAMES);
            sendto(sock, buffer, sizeof(buffer), 0,
                   (struct sockaddr*)&addr, sizeof(addr));
        }
    }

    return 0;
}
