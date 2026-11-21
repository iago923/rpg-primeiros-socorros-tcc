using System;
using System.IO;
using System.Text;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Web.Script.Serialization;

// Loopback only; no credentials, telemetry or remote database.
class Servidor {
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_open(byte[] p,out IntPtr db);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_close(IntPtr db);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_prepare_v2(IntPtr db,byte[] sql,int n,out IntPtr stmt,IntPtr tail);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_bind_text(IntPtr s,int i,byte[] val,int n,IntPtr free);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_step(IntPtr s);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern int sqlite3_finalize(IntPtr s);
 [DllImport("winsqlite3",CallingConvention=CallingConvention.Cdecl)] static extern IntPtr sqlite3_column_text(IntPtr s,int n);
 static IntPtr db;
 static JavaScriptSerializer json=new JavaScriptSerializer { MaxJsonLength=262144, RecursionLimit=32 };
 static byte[] U(string s){return Encoding.UTF8.GetBytes(s+"\0");}
 static string Text(IntPtr p){if(p==IntPtr.Zero)return ""; int n=0;while(Marshal.ReadByte(p,n)!=0)n++;byte[] b=new byte[n];Marshal.Copy(p,b,0,n);return Encoding.UTF8.GetString(b);}
 static List<string[]> Sql(string sql,params object[] args){
  IntPtr s; if(sqlite3_prepare_v2(db,U(sql),-1,out s,IntPtr.Zero)!=0)throw new Exception("Falha ao preparar SQL");
  try {
   for(int i=0;i<args.Length;i++){byte[] b=U(Convert.ToString(args[i],System.Globalization.CultureInfo.InvariantCulture));if(sqlite3_bind_text(s,i+1,b,b.Length-1,new IntPtr(-1))!=0)throw new Exception("Parametro invalido");}
   var rows=new List<string[]>(); int rc;
   while((rc=sqlite3_step(s))==100){rows.Add(new[]{Text(sqlite3_column_text(s,0))});}
   if(rc!=101)throw new Exception("Banco recusou a operacao");return rows;
  } finally {sqlite3_finalize(s);}
 }
 static string Hash(string s){using(var h=SHA256.Create())return Convert.ToBase64String(h.ComputeHash(Encoding.UTF8.GetBytes(s)));}
 static Dictionary<string,object> Obj(object o){var d=o as Dictionary<string,object>;if(d==null)throw new Exception("Objeto invalido");return d;}
 static int Num(object o,int min,int max){double d=Convert.ToDouble(o);if(d<min||d>max||d!=Math.Floor(d))throw new Exception("Numero invalido");return (int)d;}
 static string Str(object o,int max){var s=o as string;if(s==null||s.Length>max)throw new Exception("Texto invalido");return s;}
 static Dictionary<string,int> limits=new Dictionary<string,int>{{"kit",1},{"luvas",4},{"gaze",6},{"cobertura",4},{"manta",1},{"bolsa",1}};
 static string[] rooms={"rm_hub","rm_secretaria","rm_treinamento","rm_cantina","rm_enfermaria","rm_quadra","rm_laboratorio","rm_banheiros","rm_sala_aula"};
 static IList Arr(object o){var a=o as IList;if(a==null)throw new Exception("Lista invalida");return a;}
 static void Validate(Dictionary<string,object> s){
  Num(s["version"],1,1);if(!rooms.Contains(Str(s["room_id"],40)))throw new Exception("Room desconhecida");
  if(!new[]{"baixo","cima","esquerda","direita"}.Contains(Str(s["facing"],12)))throw new Exception("Direcao invalida");
  foreach(string k in new[]{"x","y","seconds"}){double v=Convert.ToDouble(s[k]);if(double.IsNaN(v)||double.IsInfinity(v)||v<0||v>10000000)throw new Exception("Posicao/tempo invalido");}
  if(!new[]{0,1,2,3,4,5,6,7,8,9,10,11,12,31,61,91,100,101,102,103,104,110}.Contains(Num(s["mission"],0,110)))throw new Exception("Missao desconhecida");Num(s["xp"],0,100000);
  foreach(string bag in new[]{"bag","locker"}){
   var a=Arr(s[bag]);int cap=bag=="bag"?8:24;if(a.Count>cap)throw new Exception("Capacidade excedida");var used=new HashSet<int>();
   foreach(object v in a){var e=Obj(v);string id=Str(e["item_id"],32);if(!limits.ContainsKey(id))throw new Exception("Item desconhecido");Num(e["quantity"],1,limits[id]);if(!used.Add(Num(e["slot"],0,cap-1)))throw new Exception("Slot duplicado");Str(e["state"],40);}
  }
  foreach(string k in new[]{"progress","learning","world"}){var d=Obj(s[k]);if(d.Count>100)throw new Exception("Estado excedido");foreach(var e in d){Str(e.Key,64);if(json.Serialize(e.Value).Length>4096)throw new Exception("Estado muito longo");}}
  Str(s["objective"],180);
  var world=Obj(s["world"]);
  foreach(string key in new[]{"intro","capacitado","finalizado"})if(!(world[key] is bool))throw new Exception("Flag invalida");
  foreach(string key in new[]{"conhecimento","avaliacao","engasgo","estabilizacao"})Num(world[key],0,1);
  var flags=Obj(world["flags"]);
  if(flags.ContainsKey("atendimento") && flags["atendimento"]!=null){
   var c=Obj(flags["atendimento"]);int topic=Num(c["topic"],0,4);
   Num(c["step"],0,new[]{2,5,5,4,4}[topic]-1);Num(c["stock"],0,3);
   Str(c["reward"],64);Str(c["feedback"],1500);Str(c["selected"],32);
   if(!new[]{"","bolsa","apoio"}.Contains(Str(c["source"],16)))throw new Exception("Origem de material invalida");
   foreach(string key in new[]{"correct","consumed","training","taught","guided"})if(!(c[key] is bool))throw new Exception("Etapa invalida");
   if(!new[]{-1,3,6,9,12,101,102,103,104,110}.Contains(Num(c["next_mission"],-1,110)))throw new Exception("Destino de etapa invalido");
   if(Convert.ToBoolean(c["consumed"]) && (topic!=3 || Convert.ToInt32(c["step"])<2))throw new Exception("Consumo fora da etapa");
  }
  foreach(var e in Obj(s["learning"])){var l=Obj(e.Value);if(!(l["lido"] is bool)||!(l["praticado"] is bool))throw new Exception("Aprendizagem invalida");}
 }
 static object Dispatch(string path,Dictionary<string,object> req){
  if(path=="/health")return new{ok=true,service="rpg-socorros",schema=1};
  if(path=="/settings"){
   if(req.ContainsKey("data")){Sql("INSERT OR REPLACE INTO configuracoes VALUES(1,?)",json.Serialize(req["data"]));return new{ok=true};}
   var r=Sql("SELECT dados FROM configuracoes WHERE id=1");return new{ok=true,data=r.Count==0?null:json.DeserializeObject(r[0][0])};
  }
  if(path=="/slots"){
   var a=new List<object>();for(int i=1;i<=3;i++){
    var r=Sql("SELECT snapshot FROM partidas WHERE slot=?",i);
    if(r.Count==0){a.Add(new{slot=i,state="empty"});continue;}
    try{var s=Obj(json.DeserializeObject(r[0][0]));Validate(s);string h=Sql("SELECT checksum FROM partidas WHERE slot=?",i)[0][0];if(Hash(r[0][0])!=h)throw new Exception();a.Add(new{slot=i,state="ready",data=s,updated=Sql("SELECT atualizado FROM partidas WHERE slot=?",i)[0][0]});}
    catch{a.Add(new{slot=i,state="invalid"});}
   }return new{ok=true,slots=a};
  }
  int slot=Num(req["slot"],1,3);
  if(path=="/load"||path=="/recover"){
   string table=path=="/load"?"partidas":"recuperacao";
   var r=Sql("SELECT snapshot FROM "+table+" WHERE slot=?",slot);if(r.Count==0)throw new Exception("Partida ou copia vazia");
   string payload=r[0][0];if(Hash(payload)!=Sql("SELECT checksum FROM "+table+" WHERE slot=?",slot)[0][0])throw new Exception("Partida invalida: tente recuperar a copia");
   var s=Obj(json.DeserializeObject(payload));Validate(s);return new{ok=true,data=s};
  }
  if(path!="/save")throw new Exception("Rota desconhecida");
  var state=Obj(req["data"]);Validate(state);string snap=json.Serialize(state);
  if(req.ContainsKey("new_game")&&Convert.ToBoolean(req["new_game"])&&Sql("SELECT slot FROM partidas WHERE slot=?",slot).Count>0&&!Convert.ToBoolean(req["overwrite"]))throw new Exception("Sobrescrita exige confirmacao");
  Sql("BEGIN IMMEDIATE");
  try{
   var previous=Sql("SELECT snapshot FROM partidas WHERE slot=?",slot);
   if(previous.Count>0&&Hash(previous[0][0])==Sql("SELECT checksum FROM partidas WHERE slot=?",slot)[0][0]){
    Validate(Obj(json.DeserializeObject(previous[0][0])));
    Sql("INSERT OR REPLACE INTO recuperacao SELECT slot,snapshot,checksum FROM partidas WHERE slot=?",slot);
   }
   Sql("DELETE FROM partidas WHERE slot=?",slot);
   Sql("INSERT INTO partidas VALUES(?,?,?,?,?,?,?,?,?,?,?)",slot,1,state["mission"],state["seconds"],DateTime.Now.ToString("yyyy-MM-dd HH:mm"),state["room_id"],state["x"],state["y"],state["facing"],snap,Hash(snap));
   foreach(string bag in new[]{"bag","locker"})foreach(object v in Arr(state[bag])){var e=Obj(v);Sql("INSERT INTO inventario VALUES(?,?,?,?,?,?)",slot,bag=="bag"?"bolsa":"armario",e["slot"],e["item_id"],e["quantity"],e["state"]);}
   foreach(string kind in new[]{"progress","learning","world"})foreach(var e in Obj(state[kind])){string table=kind=="progress"?"progresso":kind=="learning"?"aprendizagem":"mundo";Sql("INSERT INTO "+table+" VALUES(?,?,?)",slot,e.Key,json.Serialize(e.Value));}
   Sql("COMMIT");
  }catch{Sql("ROLLBACK");throw;}
  return new{ok=true,slot=slot};
 }
 static void Main(string[] args){
  try{Run(args);}catch(Exception error){
   string dir=args.Length>0?Path.GetFullPath(args[0]):Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),"RPGPrimeirosSocorros");
   try{Directory.CreateDirectory(dir);File.WriteAllText(Path.Combine(dir,"servico_erro.log"),DateTime.Now.ToString("s")+" "+error.Message);}catch{}
  }
 }
 static void Run(string[] args){
  string dir=args.Length>0?Path.GetFullPath(args[0]):Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),"RPGPrimeirosSocorros");Directory.CreateDirectory(dir);
  if(sqlite3_open(U(Path.Combine(dir,"partidas.sqlite3")),out db)!=0)throw new Exception("Nao foi possivel abrir o banco");
  try{
   int version=int.Parse(Sql("PRAGMA user_version")[0][0]);if(version>1)throw new Exception("Banco de versao futura: nao sera alterado");
   foreach(string stmt in File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory,"schema.sql")).Split(';'))if(stmt.Trim().Length>0)Sql(stmt);
   Sql("PRAGMA busy_timeout=3000");
   var listener=new TcpListener(IPAddress.Loopback,19827);listener.Start();
   for(;;)using(TcpClient client=listener.AcceptTcpClient()){
    client.ReceiveTimeout=4000;client.SendTimeout=4000;
    try{
     using(var stream=client.GetStream()){
      var header=new List<byte>();int b;while((b=stream.ReadByte())>=0){header.Add((byte)b);if(header.Count>8192)throw new Exception("Header extenso");if(header.Count>=4&&Encoding.ASCII.GetString(header.Skip(header.Count-4).ToArray())=="\r\n\r\n")break;}
      string[] lines=Encoding.ASCII.GetString(header.ToArray()).Split(new[]{"\r\n"},StringSplitOptions.None);string[] first=lines[0].Split(' ');int len=0;bool authorized=false;
      foreach(string line in lines){if(line.StartsWith("Content-Length:",StringComparison.OrdinalIgnoreCase))len=int.Parse(line.Substring(15).Trim());if(line.Equals("X-RPG-Client: desktop-v1",StringComparison.OrdinalIgnoreCase))authorized=true;}
      object result;int status=200;
      try{
       if(!authorized||first[0]!="POST")throw new Exception("Cliente nao autorizado");if(len<0||len>262144)throw new Exception("Payload excedido");
       byte[] body=new byte[len];int n=0;while(n<len){int k=stream.Read(body,n,len-n);if(k==0)throw new Exception("Pedido incompleto");n+=k;}
       result=Dispatch(first[1],Obj(json.DeserializeObject(Encoding.UTF8.GetString(body))));
      }catch(Exception e){status=400;result=new{ok=false,error=e.Message};}
      byte[] output=Encoding.UTF8.GetBytes(json.Serialize(result));byte[] prefix=Encoding.ASCII.GetBytes("HTTP/1.1 "+status+" Result\r\nContent-Type: application/json; charset=utf-8\r\nContent-Length: "+output.Length+"\r\nConnection: close\r\n\r\n");stream.Write(prefix,0,prefix.Length);stream.Write(output,0,output.Length);
     }
    }catch(IOException){}catch(System.Net.Sockets.SocketException){}
   }
  }finally{sqlite3_close(db);}
 }
}
