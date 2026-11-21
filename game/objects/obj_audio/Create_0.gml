if (instance_number(obj_audio) > 1) { instance_destroy(); exit; }
dialogo_anterior = false;
xp_anterior = global.xp;
musica_id = audio_play_sound(snd_musica_escola, 0, true);
audio_sound_gain(musica_id, 0.22, 0);
