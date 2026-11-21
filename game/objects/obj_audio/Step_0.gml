audio_sound_gain(musica_id,global.cfg.music,300);
var sounds=[snd_interagir,snd_acerto,snd_erro,snd_dialogo,snd_vitoria];
for(var i=0;i<array_length(sounds);i++)audio_sound_gain(sounds[i],global.cfg.sfx,0);
