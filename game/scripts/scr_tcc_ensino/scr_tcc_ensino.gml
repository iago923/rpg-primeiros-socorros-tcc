function tcc_topicos(){
 return [
  {id:"seguranca",titulo:"Segurança e comunicação",fonte:"MS / SAMU 192 · consulta 20/09/2026",paginas:[
   "Nesta escola, você participa de um projeto de prevenção. Seu papel é reconhecer riscos, pedir ajuda e colaborar dentro do que aprendeu. Não é uma formação profissional.",
   "Antes de se aproximar, observe riscos. Peça apoio a um adulto. Não se exponha a eletricidade, produtos desconhecidos ou outros perigos.",
   "Na simulação de chamada, informe escola, ponto de acesso, local da ocorrência e o que você observou. Responda às perguntas e siga a orientação do SAMU 192.",
   "Não diagnostique nem prometa cura. Organize a passagem para a equipe e acompanhe a pessoa enquanto for seguro. O guia fica disponível mesmo com a bolsa cheia."
  ]},
  {id:"engasgo",titulo:"Engasgo · adulto de 18 anos",fonte:"AHA 2025 · SBV adulto; MS / SAMU 192",paginas:[
   "Na cantina, um aluno de 18 anos não consegue falar nem tossir com força. Objetivo: distinguir tosse eficaz de obstrução grave. A cena é fictícia.",
   "Com tosse eficaz, incentive a tosse e observe. Tosse fraca ou ausente e incapacidade de falar sugerem obstrução grave: acione ajuda.",
   "Ele está acordado e reage: aqui, consciente significa isso. Como não fala nem tosse com força, precisa de ajuda imediata. A AHA 2025 orienta alternar 5 golpes nas costas e 5 compressões abdominais; aprenda a técnica presencialmente.",
   "Não faça varredura cega com os dedos. Se perder a resposta, a conduta muda para RCP orientada. Após desobstruir, continue observando até o atendimento. Não há item que substitua essas ações."
  ]},
  {id:"desmaio",titulo:"Pessoa sem resposta · 18 anos",fonte:"AHA / Cruz Vermelha 2024, seção 5.1; SAMU 192",paginas:[
   "Na quadra, uma aluna de 18 anos está sem resposta. Não presuma que é apenas um desmaio. Objetivo: reconhecer quando pedir ajuda e avaliar respiração.",
   "Observe segurança, resposta e respiração. Acione o SAMU. Respiração ausente ou anormal exige seguir orientação de RCP, não aguardar melhora espontânea.",
   "Neste caso a respiração é normal e não há trauma observado. A posição lateral pode ser indicada. Se houver suspeita de trauma, a decisão muda; siga a orientação recebida.",
   "Acompanhe a respiração. Não ofereça bebida à pessoa inconsciente. Um kit não a faz acordar. A chamada e o acompanhamento são parte do atendimento."
  ]},
  {id:"queimadura",titulo:"Queimadura térmica · 18 anos",fonte:"AHA / Cruz Vermelha 2024, seção 9.8; MS / SAMU",paginas:[
   "No laboratório, um aluno de 18 anos encostou no recipiente quente. A fonte já foi desligada pelo funcionário. É queimadura térmica, não elétrica ou química.",
   "Resfrie com água corrente limpa. Neste exercício não há cronômetro de manobra: o foco é escolher o recurso adequado.",
   "Após resfriar, uma cobertura limpa não aderente protege a área, sem apertar. Selecionar a cobertura na bolsa não a consome; apenas confirmar a etapa válida.",
   "Não aplique receitas caseiras nem arranque tecido aderido. Queimadura extensa, profunda ou com dificuldade de respirar exige ajuda urgente. Se faltar cobertura, peça que o apoio traga; não abandone a pessoa."
  ]},
  {id:"queda",titulo:"Queda e suspeita de trauma · 18 anos",fonte:"AHA / Cruz Vermelha 2024, seção 9.4; SAMU 192",paginas:[
   "No corredor, um aluno de 18 anos caiu e refere dor nas costas. Objetivo: evitar agravar uma lesão enquanto a ajuda é acionada.",
   "Com o local seguro, peça que permaneça parado e acione atendimento. Evite levantá-lo para testar se consegue andar.",
   "Não improvise colar cervical ou prancha como tarefa de estudante leigo. Nenhum material é obrigatório para reconhecer o risco e pedir apoio.",
   "Observe resposta e respiração e comunique mudanças ao atendimento. A prioridade pode mudar se o local se tornar perigoso. O colega pode liberar o acesso sem mover a vítima."
  ]}
 ];
}
function tcc_pergunta(_texto,_opcoes,_certa,_feedback){return {texto:_texto,opcoes:_opcoes,certa:_certa,feedback:_feedback};}
function tcc_questoes(_id){
 var ajuda=tcc_pergunta("Chamada simulada: o que informar primeiro?",["Somente o nome da pessoa","Escola, acesso e condições observadas","Esperar ter um diagnóstico"],1,["O nome não localiza a ocorrência.","Localização e observações ajudam a orientar o atendimento. A chamada é apenas interna ao jogo.","Um estudante não precisa diagnosticar para pedir ajuda."]);
 var segura=tcc_pergunta("Antes da aproximação, qual decisão protege todos?",["Observar riscos e solicitar apoio","Ir direto e avaliar depois","Levar a pessoa para outra sala"],0,["Segurança do local vem antes da aproximação.","A pressa pode expor mais pessoas ao risco.","Mudar de sala não é uma regra segura para toda ocorrência."]);
 switch(_id){
 case "seguranca":return [segura,ajuda];
 case "engasgo":return [segura,tcc_pergunta("O aluno não fala e a tosse é fraca. Qual interpretação?",["Tosse eficaz: apenas observar","Dificuldade sem necessidade de apoio","Possível obstrução grave: chamar ajuda"],2,["Tosse eficaz é diferente dos sinais apresentados.","Os sinais indicam urgência.","Reconhecer gravidade permite pedir ajuda sem esperar um kit."]),ajuda,tcc_pergunta("Qual sequência corresponde à orientação de 2025 para este adulto consciente?",["Alternar 5 golpes nas costas e 5 compressões abdominais","Só oferecer água","Aplicar a sequência sem verificar se ainda responde"],0,["Esse é o ciclo descrito na fonte para este caso. A técnica deve ser aprendida na prática.","Água não resolve a obstrução grave e atrasa a resposta.","Perder a resposta muda a conduta. É necessário reavaliar."]),tcc_pergunta("O objeto saiu. O atendimento terminou?",["Sim, pode ficar sozinho","Não: observar e seguir orientação","Sim, basta guardar os materiais"],1,["A melhora não dispensa acompanhamento.","O desfecho inclui observação e comunicação com a ajuda.","Materiais não são a prioridade neste caso."])];
 case "desmaio":return [
  segura,
  tcc_pergunta("Pessoa sem resposta: o que diferencia os próximos passos?",["A quantidade de materiais no estojo","Se alguém já teve um desmaio parecido","A respiração e a possibilidade de trauma"],2,["O estojo não determina a conduta.","Uma experiência anterior não substitui observar as condições desta pessoa.","Essas observações mudam a orientação; não presuma um desmaio simples."]),
  ajuda,
  tcc_pergunta("Respira normalmente, sem trauma observado. Qual escolha é coerente?",["Dar água para ajudar a acordar","Seguir orientação de posicionamento e acompanhar","Deixá-la sozinha para buscar o kit"],1,["Uma pessoa inconsciente não deve receber bebida.","Acompanhamento continua sendo essencial.","Peça ao apoio que traga algo, sem abandonar a pessoa."]),
  tcc_pergunta("A respiração se torna anormal. O que fazer?",["Comunicar imediatamente e seguir orientação de RCP","Aguardar para ver se a respiração normaliza","Manter a mesma conduta sem reavaliar"],0,["Mudanças exigem reavaliação imediata.","A mudança observada precisa ser comunicada imediatamente; esperar não é a resposta indicada.","A conduta deve acompanhar o estado observado."])
 ];
 case "queimadura":return [segura,tcc_pergunta("Fonte térmica já afastada: qual recurso usar para resfriar?",["Uma receita caseira","Água corrente limpa","Um curativo apertado"],1,["Produtos caseiros não são o recurso indicado.","A água corrente limpa é a primeira escolha de resfriamento.","Cobrir antes não substitui resfriar."]),tcc_pergunta("Após resfriar, como conseguir a cobertura indicada?",["Confirmar cobertura da bolsa","Pedir ao apoio uma cobertura","Aplicar qualquer produto disponível"],0,["A confirmação usa uma unidade, nunca o pacote inteiro.","Pedir material ao apoio também é uma alternativa segura.","A disponibilidade não torna um produto adequado."]),tcc_pergunta("Se houver dificuldade para respirar, qual a prioridade?",["Organizar a bolsa primeiro","Esperar voltar à aula","Acionar atendimento e acompanhar"],2,["Organização não deve atrasar ajuda.","Esse sinal exige atenção urgente.","A gravidade muda a prioridade, independentemente dos materiais."])];
 case "queda":return [segura,ajuda,tcc_pergunta("Dor nas costas após queda, local seguro: qual escolha?",["Levantar para verificar se anda","Evitar movimentos e acompanhar","Improvisar um colar rígido"],1,["Esse teste pode agravar a lesão.","Manter a pessoa parada e aguardar orientação é coerente com este caso.","Não é uma tarefa para estudante leigo."]),tcc_pergunta("Como Rafa pode ajudar sem mover a vítima?",["Liberar acesso e orientar a chegada do socorro","Puxá-la até a porta","Buscar todos os itens e deixar o local vazio"],0,["Apoio e comunicação fazem parte do cuidado.","Mover não é necessário com o local seguro.","Não é preciso abandonar a pessoa para reunir materiais."])];
 }return [segura,ajuda];
}
function tcc_estudar(_index){global.tcc_topic=_index;tcc_abrir("guia");}
function tcc_cena(_c){
 var cenas=[
  "Ana recebe sua turma na oficina da escola. Você recebe uma bolsa reutilizável. Primeiro, ela mostra como observar o local e pedir ajuda. Os materiais não substituem essas duas ações.",
  "Na cantina, um colega de 18 anos interrompe o lanche. Ele olha para você e tenta responder, mas não consegue falar nem tossir com força. Ana está perto e chama apoio.",
  "Na quadra, uma colega de 18 anos parou de responder. O professor viu quando ela se deitou: não houve queda nem batida. Ela respira normalmente. O professor permanece ao lado dela.",
  "No laboratório, um colega de 18 anos encostou o antebraço num recipiente quente. Ele responde, sente dor e mostra uma pequena área avermelhada, com pele intacta. O funcionário desligou a fonte de calor.",
  "No corredor, um colega de 18 anos caiu e diz que sente dor nas costas. Está acordado e responde. Rafa afasta os curiosos. O caminho está seguro; não é preciso mover o colega."
 ];
 if(_c.training)return "Oficina supervisionada, sem uma pessoa ferida. Ana usa um modelo de treino e apresenta esta situação: "+cenas[_c.topic];
 return cenas[_c.topic];
}
function tcc_orientacao(_topic,_step){
 var textos=[];
 switch(_topic){
 case 0:textos=["Ana: primeiro olho ao redor. Não me aproximo de fios, calor ou produtos desconhecidos. Peço um adulto para ajudar: proteger quem socorre também faz parte do cuidado.","Ana demonstra a chamada: 'SAMU 192, estamos na escola, entrada principal. Vou informar a sala e o que vejo.' O atendente faz perguntas; não precisamos inventar um diagnóstico."];break;
 case 1:textos=["Ana confere o local e pede apoio. O colega ainda reage, mas isso não significa que esteja fora de perigo. Observe especialmente a fala e a força da tosse.","Ele tenta falar, mas não sai voz; a tosse é fraca. Isso é diferente de tossir com força. São sinais de obstrução grave: peça ajuda imediatamente, sem buscar materiais.","Ana pede a Rafa que acione o SAMU 192 e indique o acesso à cantina. Você informa que o colega reage, mas não consegue falar nem tossir com força.","Ana explica a orientação para este adulto que ainda reage: alternar 5 golpes nas costas e 5 compressões abdominais. Se parar de responder, a conduta muda para RCP. A execução precisa de treinamento prático.","Na cena, o objeto foi expelido e o colega volta a falar. A melhora não encerra o cuidado: permaneça com ele e siga as orientações da equipe de atendimento."];break;
 case 2:textos=["O professor confirma que o local está seguro. A colega não responde à voz. Não concluir que é 'só um desmaio' evita deixar passar uma situação mais séria.","Observe a respiração e pergunte se houve queda ou batida. Aqui ela respira normalmente e o professor não viu trauma. Essas informações mudam o próximo passo.","Informe ao SAMU 192 onde estão, que ela não responde, respira normalmente e não houve trauma observado. Responda às perguntas do atendente.","O professor segue a orientação de posicionamento lateral e acompanha a respiração. Lateral significa de lado. Não dar bebida: alguém que não responde pode não conseguir engolir com segurança.","O professor nota uma mudança: a respiração deixou de ser normal. Comunique imediatamente ao SAMU e siga a orientação de RCP. A orientação anterior precisa ser reavaliada."];break;
 case 3:textos=["Ana confere que a fonte de calor foi desligada e que não há eletricidade ou produto químico envolvido. O colega responde. Só se aproxime quando for seguro.","O funcionário conduz o resfriamento com água corrente limpa. O botão representa escolher a conduta, não uma duração de tratamento. Na prática, o resfriamento não dura apenas o tempo de um clique.","O resfriamento terminou sob orientação. Ana mostra uma cobertura limpa que não gruda: ela protege a pele intacta sem apertar, enquanto aguardam avaliação. Abra a bolsa, escolha a cobertura e confira antes de aplicar.","A cobertura protege, mas não cura a queimadura. O funcionário assume o acompanhamento. Se surgir dificuldade para respirar, a prioridade é pedir atendimento imediatamente, não organizar a bolsa."];break;
 case 4:textos=["Rafa verificou o caminho e afastou os curiosos. Não há perigo imediato no local. O colega responde e pede ajuda por causa da dor nas costas.","Informe ao SAMU 192 o local da queda, a dor nas costas e que o colega responde. Rafa pode orientar a equipe na entrada enquanto você permanece próximo.","Com o local seguro, não levante o colega para testar se consegue andar. Evitar movimentos desnecessários reduz o risco de agravar uma lesão. Aguarde a orientação do atendimento.","Rafa libera a passagem para a equipe sem puxar o colega. Ajudar também é organizar o acesso e comunicar mudanças na resposta ou na respiração."];break;
 }return textos[min(_step,array_length(textos)-1)];
}
function tcc_material_etapa(){var c=global.tcc_case;return is_struct(c)&&c.topic==3&&c.step==2;}
function tcc_escolher_material(_id){
 var c=global.tcc_case;if(!tcc_material_etapa()||c.consumed)return false;
 c.selected=_id;c.feedback="";
 if(_id!="cobertura"){
  global.tcc_notice="Aqui precisamos proteger a pele já resfriada sem grudar nem apertar. Este item não faz essa ação. Nada foi gasto.";return false;
 }
 var quantidade=c.training?c.stock:tcc_quantidade(global.bolsa,_id);
 if(quantidade<=0){global.tcc_notice="Sem cobertura. Peça ao apoio que traga uma; permaneça com o colega.";return false;}
 c.source="bolsa";tcc_abrir("confirmar_material");return true;
}
function tcc_aplicar_material(){
 var c=global.tcc_case;if(!tcc_material_etapa()||c.consumed||c.selected!="cobertura"||(c.source!="bolsa"&&c.source!="apoio"))return false;
 if(c.source!="apoio"){
  if(c.training){if(c.stock<=0)return false;c.stock--;}
  else if(!tcc_consumir("cobertura","queimadura"))return false;
 }
 c.consumed=true;c.correct=true;
 c.feedback=c.source=="apoio"?"O funcionário trouxe a cobertura. Você ficou com o colega. A proteção foi colocada sem apertar; o estoque da sua bolsa não mudou.":"Cobertura colocada sem apertar. Uma unidade foi usada. Ela protege a área após o resfriamento; o acompanhamento continua.";
 if(c.training)c.feedback+=" Apenas o estoque de treino foi usado.";
 global.tcc_dirty=true;tcc_abrir("caso");if(global.tcc_slot>0)tcc_salvar();return true;
}
function tcc_iniciar_caso(_topic,_reward,_mission){
 global.tcc_case={topic:_topic,reward:_reward,next_mission:_mission,step:0,feedback:"",correct:false,consumed:false,training:global.missao>=100||_mission<0,stock:3,selected:"",source:"",taught:false};
 var topic_id=tcc_topicos()[_topic].id;
 global.tcc_case.guided=global.tcc_case.training||!variable_struct_exists(global.aprendizagem,topic_id)||!variable_struct_get(global.aprendizagem,topic_id).praticado;
 global.tcc_topic=_topic;global.tcc_page=0;tcc_abrir("cena");
}
function tcc_responder(_choice){
 var c=global.tcc_case;if(!is_struct(c)||c.feedback!="")return;
 var topic=tcc_topicos()[c.topic],qs=tcc_questoes(topic.id),q=qs[c.step];
 if(_choice<0||_choice>=array_length(q.opcoes))return;
 if(tcc_material_etapa()){
  if(_choice==0){tcc_abrir("material");return;}
  if(_choice==1){c.selected="cobertura";c.source="apoio";tcc_abrir("confirmar_material");return;}
 }
 c.correct=(_choice==q.certa);
 c.feedback=q.feedback[_choice];
 global.tcc_dirty=true;
}
function tcc_caso_avancar(){
 var c=global.tcc_case;if(!is_struct(c)||c.feedback=="")return;
 if(c.correct){c.step++;c.taught=false;}c.feedback="";c.correct=false;
 var topic=tcc_topicos()[c.topic];
 if(c.step>=array_length(tcc_questoes(topic.id))){
  tcc_concluir(c.reward);variable_struct_set(global.aprendizagem,topic.id,{lido:true,praticado:true});
  if(c.next_mission>=0)global.missao=c.next_mission;
  if(c.reward=="manual")global.conhecimento=1;
  if(c.reward=="avaliacao")global.avaliacao=1;
  if(c.reward=="treino_engasgo")global.tecnica_engasgo=1;
  if(c.reward=="estabilizacao")global.estabilizacao=1;
  if(c.reward=="prova")global.capacitado=true;
  if(c.next_mission>=0)global.nome_missao=tcc_objetivo();global.tcc_case=undefined;tcc_fechar();
  var finais=["Você observou antes de agir e comunicou o que viu. Ana: pedir ajuda é uma ação importante, mesmo sem usar material.","O colega voltou a falar e ficou acompanhado. Você reconheceu a tosse fraca e pediu ajuda sem esperar por um kit.","O professor continuou acompanhando a colega e comunicou a mudança na respiração. Uma situação pode mudar: observar continua sendo necessário.","O funcionário assume o acompanhamento. A cobertura protegeu a pele depois de resfriar; ela não substituiu a água nem a avaliação. A mesma bolsa continua com você.","Rafa recebeu a equipe, sem mover o colega com dor nas costas. Organização e comunicação também são cuidado."];
  tcc_fala(c.training?"Ana · fim da prática":"Depois do atendimento",finais[c.topic]+(c.training?" Treino concluído, sem gastar o estoque da campanha.":""));
 }
 else tcc_abrir(c.guided&&!c.taught?"orientacao":"caso");
}
function tcc_objetivo(){switch(global.missao){case 100:return "Leia o manual no treinamento";case 101:return "Avaliação inicial: estação da maca";case 102:return "Pratique decisões sobre engasgo";case 103:return "Pratique segurança após quedas";case 104:return "Converse na mesa de avaliação final";case 110:return "Volte à secretaria e converse com Ana";case 1:return "Cantina: reconheça a ocorrência";case 4:return "Quadra: avalie a pessoa sem resposta";case 7:return "Laboratório: queimadura térmica";case 10:return "Corredor: ajude após uma queda";default:return "Volte à professora Ana na secretaria";}}
