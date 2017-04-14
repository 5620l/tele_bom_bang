--Begin GroupManager.lua By @bombangteam
local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '● ➢*Yσυ αяє ησт вσт α∂мιη*🚷'
else
     return '↫●_شما مدیر ربات نیستید_🚷'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '_♻️Gяσυρ ιѕ αℓяєα∂у α∂∂є∂♻️_'
else
return '↫●_♻️گروه از قبل ثبت شده بود♻️_'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'yes',
          lock_markdown = 'no',
		  lock_mention = 'no',
		  lock_persian = 'no',
		  lock_edit = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
		  lock_tabchi = 'no',
          welcome = 'no',
				   english = 'no',
				   views = 'no',
				   emoji ='no',
				   ads = 'no',
				   fosh = 'no'
				   
          },
		  lock = {
		    lock_fwd = 'yes',
                  lock_audio = 'no',
                  lock_video = 'no',
                  lock_contact = 'yes',
                  lock_text = 'no',
                  lock_photos = 'no',
                  lock_gif = 'no',
                  lock_loc = 'no',
                  lock_doc = 'no',
                  lock_sticker = 'no',
                  lock_voice = 'no',
                   lock_all = 'no',
				   lock_keyboard = 'yes'
		  }
      }
 save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*✔️Group has been added✔️*'
else
  return '✔️گروه با موفقیت ثبت شد✔️'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '↫●*Yσυ αяє ησт вσт α∂мιη*‼️'
   else
        return '↫●_شما مدیر ربات نیستید_‼️'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '↫●*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*'
else
    return '_↫●گروه در لیست گروه های پشتیبانی نیست❌❗️_'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*↫●Gяσυρ нαѕ вєєη яємσνє∂✅*'
 else
  return '_↫●گروه از لیست گروه های پشتیبانی حذف شد✅_'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "↫●_Wσя∂_ *"..word.."* _ιѕ αℓяєα∂у ƒιℓтєяє∂_♻️"
            else
         return "↫●_کلمه_ *"..word.."* _از قبل فیلتر بود_♻️"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "↫●_Wσя∂_ *"..word.."* _α∂∂є∂ тσ ƒιℓтєяє∂ ωσя∂ѕ ℓιѕт_✅"
            else
         return "↫●_کلمه_ *"..word.."* _به لیست کلمات فیلتر اضافه شد_✅"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "↫●_Wσя∂_ *"..word.."* _яємσνє∂ ƒяσм ƒιℓтєяє∂ ωσя∂ѕ ℓιѕт_❌"
       elseif lang then
         return "↫●_کلمه_ *"..word.."* _از لیست کلمات فیلتر حذف شد_❌"
     end
      else
       if not lang then
         return "↫●_Wσя∂_ *"..word.."* _ιѕ ησт ƒιℓтєяє∂_❕"
       elseif lang then
         return "↫●_کلمه_ *"..word.."* _از قبل فیلتر نبود_❕"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "↫●*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*"
 else
    return "_↫●گروه در لیست گروه های پشتیبانی نیست❌❗️_"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "↫●_Nσ_ *мσ∂єяαтσя* _ιη тнιѕ gяσυρ_❗️❕"
else
   return "↫●_در این گروه هیچ معاونی برای ربات انتخاب نشده است❗️👤_"
  end
end
if not lang then
   message = '☆》📋*Lιѕт σƒ мσ∂єяαтσяѕ :*\n'
else
   message = '☆》📋لیست معاون های گروه \n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "↫●*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*"
else
return "↫●_در این گروه هیچ معاونی برای ربات انتخاب نشده است❗️👤_"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "↫●_Nσ_ *σωηєя* _ιη тнιѕ gяσυρ_❕👤"
else
    return "↫●هیچ مدیری برای ربات در این گروه انتخاب نشده است❕👤"
  end
end
if not lang then
   message = '☆》📋*Lιѕт σƒ мσ∂єяαтσяѕ :*\n'
else
   message = '☆》📋*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "↫●*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_↫●گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل مدیر نبود*❌", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "● ➢*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_↫●گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "● ➢Rєѕυℓт ƒσя📄 [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "↫●اطلاعات برای📄 [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "● ➢*Gяσυρ ιѕ ησт α∂∂є∂❌❗️*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_↫●گروه درلیست گروه های پشتیبانی نیست❌❗️_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *gяσυρ σωηєя*♻️", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر"..user_name.." *"..data.id_.."* *از قبل مدیر بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησω тнє_ *gяσυρ σωηєя*✅", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *مدیر گروه شد*✅", 0, "md")   end
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ αℓяєα∂у α_ *мσ∂єяαтσя*♻️", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون گروه بود*♻️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *ρяσмσтє∂*✅", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *معاون گروه شد*✅", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *gяσυρ σωηєя*❌", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ∂ємσтє σƒ_ *gяσυρ σωηєя*✅", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام مدیر برکنار شد*✅", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _ιѕ ησт α_ *мσ∂єяαтσя*❗️", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از قبل معاون نبود*❗️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤_Uѕєя_ "..user_name.." *"..data.id_.."* _нαѕ вєєη_ *∂ємσтє∂*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "☆》👤کاربر "..user_name.." *"..data.id_.."* *از مقام معاون گروه برکنار شد*✅", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = '☆》ησт ƒσυη∂❗️'
 else
username = '☆》ندارد❗️'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, '☆》Iηƒσ ƒσя📃 [ '..data.id_..' ] :\n👤UѕєяNαмє : '..username..'\n💎Nαмє : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, '☆》اطلاعات برای📃  [ '..data.id_..' ] :\n👤یوزرنیم : '..username..'\n💎نام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "", 0, "md")
    end
  end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "☆》*Lιηк* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ لینک در گروه  از قبلا فعال است🔒"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lιηк* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ لینک در گروه  از قبلا فعال است🔒"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "☆》*Lιηк* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ لینک در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lιηк* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫ لینک در گروه  ازاد شد🔓"
end
end
end
---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "☆》*Tαg* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ هشتگ و یوزرنیم در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Tαg* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ هشتگ و یوزرنیم در گروه فعال شد🔒"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "☆》*Tαg* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ هشتگ و یوزرنیم در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Tαg* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫ هشتگ و یوزرنیم در گروه  ازاد شد🔓"
end
end
end
---------------Lock Vewis-------------------
local function lock_views(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_views = data[tostring(target)]["settings"]["views"] 
if lock_views == "yes" then
if not lang then
 return "↫ Views _Posting Is Already Locked_"
elseif lang then
 return "قفل ↫ پست ویو دار در گروه هم اکنون فعال است🔒"
end
else
 data[tostring(target)]["settings"]["views"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "↫ Views _Posting Has Been Locked_"
else
 return "قفل ↫ پست ویو دار در گروه فعال شد🔒"
end
end
end

local function unlock_views(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_views = data[tostring(target)]["settings"]["views"]
 if lock_views == "no" then
if not lang then
return "↫ Views _Posting Is Not Locked_" 
elseif lang then
return "قفل ↫ پست ویو دار در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["views"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "↫ Views _Posting Has Been Unlocked_" 
else
return "قفل ↫ پست ویو دار در گروه آزاد شد🔓"
end
end
end
---------------Lock English-------------------
local function lock_english(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_english = data[tostring(target)]["settings"]["english"] 
if lock_english == "yes" then
if not lang then
 return "☆》*Eηgℓιѕн* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "●》نوشته انگلیسی در گروه از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["english"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Eηgℓιѕн* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》نوشته انگلیسی در گروه فعال شد🔒"
end
end
end

local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_english = data[tostring(target)]["settings"]["english"]
 if lock_english == "no" then
if not lang then
return "☆》*єηgℓιѕн* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》نوشته انگلیسی در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["english"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Eηgℓιѕн* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》نوشته انگلیسی در گروه آزاد شد🔓"
end
end
end
---------------Lock Emoji-------------------
local function lock_emoji(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_emoji = data[tostring(target)]["settings"]["emoji"] 
if lock_emoji == "yes" then
if not lang then
 return "☆》*Eмσנι* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》نوشته ایموجی در گروه از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["emoji"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Eмσנι* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》نوشته ایموجی در گروه فعال شد🔒"
end
end
end

local function unlock_emoji(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_emoji = data[tostring(target)]["settings"]["emoji"]
 if lock_emoji == "no" then
if not lang then
return "☆》*Eмσנι* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》نوشته ایموجی در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["emoji"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Eмσנι* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》نوشته ایموجی در گروه آزاد شد🔓"
end
end
end
---------------Lock Ads-------------------
local function lock_ads(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_ads = data[tostring(target)]["settings"]["ads"] 
if lock_ads == "yes" then
if not lang then
 return "☆》*A∂ѕ* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل تبلیغات در گروه از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["ads"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*A∂ѕ* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_"
else
 return "☆》قفل تبلیغات در گروه فعال شد"
end
end
end

local function unlock_ads(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_ads = data[tostring(target)]["settings"]["ads"]
 if lock_ads == "no" then
if not lang then
return "☆》*α∂ѕ* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "قفل تبلیغات در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["ads"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*A∂ѕ* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل تبلیغات در گروه آزاد شد🔓"
end
end
end
---------------Lock Fosh-------------------
local function lock_fosh(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_fosh = data[tostring(target)]["settings"]["fosh"] 
if lock_fosh == "yes" then
if not lang then
 return "↫ Fosh _Posting Is Already Locked_"
elseif lang then
 return "قفل ↫ کلمات رکیک در گروه هم اکنون فعال است🔒"
end
else
 data[tostring(target)]["settings"]["fosh"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "↫ Fosh _Posting Has Been Locked_"
else
 return "قفل ↫ کلمات رکیک در گروه فعال شد🔒"
end
end
end

local function unlock_fosh(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_fosh = data[tostring(target)]["settings"]["english"]
 if lock_fosh == "no" then
if not lang then
return "↫ Fosh _Posting Is Not Locked_" 
elseif lang then
return "قفل ↫ کلمات رکیک در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["fosh"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "↫ Fosh _Posting Has Been Unlocked_" 
else
return "قفل ↫ کلمات رکیک در گروه آزاد شد🔓"
end
end
end
---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "☆》*Mєηтιση* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ فراخوانی در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "☆》*Mєηтιση* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else 
 return "☆》قفل ↫ فراخوانی در گروه فعال شد🔒"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "☆》*Mєηтιση* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ فراخوانی در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Mєηтιση* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫  فراخوانی در گروه  ازاد شد🔓"
end
end
end

---------------Lock Arabic--------------
local function lock_persian(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_persian = data[tostring(target)]["settings"]["lock_persian"] 
if lock_persian == "yes" then
if not lang then
 return "☆》*Pєяѕιαη* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ کلمات فارسی در گروه  از قبلا فعال است🔒"
end
else
data[tostring(target)]["settings"]["lock_persian"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Pєяѕιαη* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ کلمات فارسی در گروه فعال شد🔒"
end
end
end

local function unlock_persian(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_persian = data[tostring(target)]["settings"]["lock_persian"]
 if lock_persian == "no" then
if not lang then
return "☆》*Pєяѕιαη* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ کلمات فارسی در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_persian"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Pєяѕιαη* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫  کلمات فارسی در گروه  ازاد شد🔓"
end
end
end
---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "☆》*E∂ιтιηg* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》↫ ویرایش پیام در گروه  از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*E∂ιтιηg* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》↫ ویرایش پیام در گروه فعال شد🔒"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "☆》*E∂ιтιηg* _Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》↫ ویرایش پیام در گروه از قبل فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*E∂ιтιηg* _Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》↫ ویرایش پیام در گروه ازاد است🔓"
end
end
end
---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "☆》*Sραм* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ هرزنامه ( اسپم) در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Sραм* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ هرزنامه ( اسپم) در گروه فعال شد🔒"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "☆》*Sραм* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
 return "☆》قفل ↫ هرزنامه (اسپم) در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Sραм* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
 return "☆》قفل ↫ هرزنامه (اسپم) در گروه  ازاد شد🔓"
end
end
end
---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "☆》*Fℓσσ∂ιηg* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ پیام مکرر در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Fℓσσ∂ιηg* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫  پیام مکرر در گروه فعال شد🔒"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "☆》*Fℓσσ∂ιηg* _Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ پیام مکرر در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Fℓσσ∂ιηg*  _Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫ پیام مکرر در گروه  ازاد شد🔓"
end
end
end
---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "☆》*Bσтѕ* _Pяσтєcтιση Iѕ Aℓяєα∂у Eηαвℓє∂_🔒"
elseif lang then
 return "☆》↫ محافظت از گروه در برابر ربات ها از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Bσтѕ* _Pяσтєcтιση Hαѕ Bєєη Eηαвℓє∂_🔒"
else
 return "☆》↫ محافظت از گروه در برابر ربات ها  فعال شد🔒"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "☆》*Bσтѕ* _Pяσтєcтιση Iѕ Nσт Eηαвℓє∂_🔓" 
elseif lang then
return "محافظت از گروه در برابر ربات ها غیرفعال است"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Bσтѕ* _Pяσтєcтιση Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》↫ محافظت از گروه در برابر ربات ها  ازاد است🔒"
end
end
end
---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "☆》*Mαяк∂σωη* _Pσѕтιηg Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ پیام دارای فونت در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Mαяк∂σωη* _Pσѕтιηg Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ پیام دارای فونت در گروه فعال شد🔒"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "☆》*Mαяк∂σωη* _Pσѕтιηg Iѕ Nσт Lσcкє∂_🔓"
elseif lang then
return "☆》قفل ↫ پیام دارای فونت در گروه  از قبلا فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Mαяк∂σωη* _Pσѕтιηg Hαѕ Bєєη Uηℓσcкє∂_🔓"
else
return "☆》قفل ↫ پیام درای فونت در گروه  ازاد شد🔓"
end
end
end
---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "☆》*Wєвραgє* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》قفل ↫ صفحات وب در گروه  از قبلا فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Wєвραgє* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》قفل ↫ صفحات وب در گروه فعال شد🔒"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "》_شما مدیر ربات نیستید_‼️"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "☆》*Wєвραgє* _Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》قفل ↫ صفحات وب در گروه  از قبل فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Wєвραgє* _Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》قفل ↫ صفحات وب در گروه  ازاد شد🔓"
end
end
end
---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "☆》*Pιηηє∂ Mєѕѕαgє* _Iѕ Aℓяєα∂у Lσcкє∂_🔒"
elseif lang then
 return "☆》سنجاق کردن پیام در گروه از قبل فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Pιηηє∂ Mєѕѕαgє* _Hαѕ Bєєη Lσcкє∂_🔒"
else
 return "☆》سنجاق کردن پیام در گروه فعال شد🔒"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "☆》*Pιηηє∂ Mєѕѕαgє* _Iѕ Nσт Lσcкє∂_🔓" 
elseif lang then
return "☆》سنجاق کردن پیام در گروه فعال نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Pιηηє∂ Mєѕѕαgє* _Hαѕ Bєєη Uηℓσcкє∂_🔓" 
else
return "☆》سنجاق کردن پیام در گروه آزاد شد🔓"
end
end
end
--------------Lock Tabchi-------------
local function lock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"] 
if lock_tabchi == "yes" then
if not lang then
 return "*Tabchi* _Posting Is Already Locked_"
elseif lang then
 return "اوردن تبچی در گروه هم اکنون فعال است"
end
else
data[tostring(target)]["settings"]["lock_tabchi"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Tabchi* _Posting Has Been Locked_"
else
 return "اوردن تبچی در گروه فعال شد"
end
end
end

local function unlock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"]
 if lock_tabchi == "no" then
if not lang then
return "*Tabchi* _Posting Is Not Locked_" 
elseif lang then
return "اوردن تبچی در گروه فعال نمیباشد"
end
else 
data[tostring(target)]["settings"]["lock_tabchi"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Tabchi* _Posting Has Been Unlocked_" 
else
return "اوردن تبچی در گروه آزاد شد"
end
end
end

--------locks---------
--------lock all--------------------------
local function lock_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️" 
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "yes" then 
if not lang then
return "☆》*Lσcк Aℓℓ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐" 
elseif lang then
return "☆》قفل ↫ همه  از قبل فعال است🔐"
end
else 
data[tostring(target)]["settings"]["lock_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Aℓℓ* _Hαѕ Bєєη Eηαвℓє∂_🔐" 
else
return "☆》قفل ↫ همه فعال شد🔐"
end
end
end

local function unlock_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️" 
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_all = data[tostring(target)]["settings"]["lock_all"] 
if lock_all == "no" then 
if not lang then
return "☆》*Lσcк Aℓℓ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ همه فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Aℓℓ* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ همه غیرفعال شد🔓"
end 
end
end

---------------lock Gif-------------------
local function lock_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_gif = data[tostring(target)]["settings"]["lock_gif"] 
if lock_gif == "yes" then
if not lang then
 return "☆》*Lσcк Gιƒ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ تصاویر متحرک  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "☆》*Lσcк Gιƒ* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ تصاویر متحرک فعال شد🔐"
end
end
end

local function unlock_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_gif = data[tostring(target)]["settings"]["lock_gif"]
 if lock_gif == "no" then
if not lang then
return "☆》*Lσcк Gιƒ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ تصاویر متحرک فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Gιƒ* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫  تصاویر متحرک غیرفعال شد🔓"
end
end
end
---------------lock Game-------------------
local function lock_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_game = data[tostring(target)]["settings"]["lock_game"] 
if lock_game == "yes" then
if not lang then
 return "☆》*Lσcк Gαмє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ بازی های تحت وب  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Gαмє* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ بازی های تحت وب   فعال شد🔐"
end
end
end

local function unlock_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_game = data[tostring(target)]["settings"]["lock_game"]
 if lock_game == "no" then
if not lang then
return "☆》*Lσcк Gαмє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ بازی های تحت وب   فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Lσcк Gαмє* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ بازی های تحت وب  غیرفعال شد🔓"
end
end
end
---------------lock Inline-------------------
local function lock_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_inline = data[tostring(target)]["settings"]["lock_inline"] 
if lock_inline == "yes" then
if not lang then
 return "☆》*Lσcк Iηℓιηє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ کیبورد شیشه ای از قبل فعال است🔓"
end
else
 data[tostring(target)]["settings"]["lock_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Iηℓιηє* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ کیبورد شیشه ای فعال شد🔐"
end
end
end

local function unlock_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_inline = data[tostring(target)]["settings"]["lock_inline"]
 if lock_inline == "no" then
if not lang then
return "☆》*Lσcк Iηℓιηє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ کیبورد شیشه ای فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Iηℓιηє* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ کیبورد شیشه ای  غیرفعال شد🔓"
end
end
end
---------------lock Text-------------------
local function lock_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_text = data[tostring(target)]["settings"]["lock_text"] 
if lock_text == "yes" then
if not lang then
 return "☆》*Lσcк Tєχт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ متن  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Tєχт* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ متن فعال شد🔐"
end
end
end

local function unlock_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_text = data[tostring(target)]["settings"]["lock_text"]
 if lock_text == "no" then
if not lang then
return "☆》*Lσcк Tєχт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓"
elseif lang then
return "☆》قفل ↫  متن فعال نیست🔓" 
end
else 
data[tostring(target)]["settings"]["lock_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Tєχт* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫  متن غیرفعال شد🔓"
end
end
end
---------------lock photo-------------------
local function lock_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_photo = data[tostring(target)]["settings"]["lock_photo"] 
if lock_photo == "yes" then
if not lang then
 return "☆》*Lσcк Pнσтσ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ عکس  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Pнσтσ* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ عکس فعال شد🔐"
end
end
end

local function unlock_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end
 
local lock_photo = data[tostring(target)]["settings"]["lock_photo"]
 if lock_photo == "no" then
if not lang then
return "☆》*Lσcк Pнσтσ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ عکس فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Pнσтσ* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫  عکس غیرفعال شد🔓"
end
end
end
---------------lock Video-------------------
local function lock_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_video = data[tostring(target)]["settings"]["lock_video"] 
if lock_video == "yes" then
if not lang then
 return "☆》*Lσcк Vι∂єσ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ ویدیو  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "☆》*Lσcк Vι∂єσ* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ ویدیو فعال شد🔐"
end
end
end

local function unlock_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_video = data[tostring(target)]["settings"]["lock_video"]
 if lock_video == "no" then
if not lang then
return "☆》*Lσcк Vι∂єσ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ ویدیو فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Vι∂єσ* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ ویدیو غیرفعال شد🔓"
end
end
end
---------------lock Audio-------------------
local function lock_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_audio = data[tostring(target)]["settings"]["lock_audio"] 
if lock_audio == "yes" then
if not lang then
 return "☆》*Lσcк Aυ∂ισ* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ اهنگ  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Aυ∂ισ* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else 
return "☆》قفل ↫ اهنگ فعال شد🔐"
end
end
end

local function unlock_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_audio = data[tostring(target)]["settings"]["lock_audio"]
 if lock_audio == "no" then
if not lang then
return "☆》*Lσcк Aυ∂ισ* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ اهنگ فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Lσcк Aυ∂ισ* _Hαѕ Bєєη Dιѕαвℓє∂_🔓"
else
return "☆》قفل ↫ اهنگ غیرفعال شد🔓" 
end
end
end
---------------lock Voice-------------------
local function lock_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_voice = data[tostring(target)]["settings"]["lock_voice"] 
if lock_voice == "yes" then
if not lang then
 return "☆》*Lσcк Vσιcє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ صدا (صدا)  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Vσιcє* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ صدا (صدا)  فعال شد🔐"
end
end
end

local function unlock_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_voice = data[tostring(target)]["settings"]["lock_voice"]
 if lock_voice == "no" then
if not lang then
return "☆》*Lσcк Vσιcє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ صدا (صدا) فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Lσcк Vσιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ صدا (صدا) غیرفعال شد🔓"
end
end
end
---------------lock Sticker-------------------
local function lock_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"] 
if lock_sticker == "yes" then
if not lang then
 return "☆》*Lσcк Sтιcкєя* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ استیکر  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Sтιcкєя* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ استیکر فعال شد🔐"
end
end
end

local function unlock_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_sticker = data[tostring(target)]["settings"]["lock_sticker"]
 if lock_sticker == "no" then
if not lang then
return "☆》*Lσcк Sтιcкєя* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ استیکر فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Lσcк Sтιcкєя* _Hαѕ Bєєη Dιѕαвℓє∂_🔓"
else
return "☆》قفل ↫ استیکر غیرفعال شد🔓"
end 
end
end
---------------lock Contact-------------------
local function lock_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_contact = data[tostring(target)]["settings"]["lock_contact"] 
if lock_contact == "yes" then
if not lang then
 return "☆》*Lσcк Cσηтαcт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ قفل مخاطب  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Cσηтαcт* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ قفل مخاطب فعال شد🔐"
end
end
end

local function unlock_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_contact = data[tostring(target)]["settings"]["lock_contact"]
 if lock_contact == "no" then
if not lang then
return "☆》*Lσcк Cσηтαcт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ قفل مخطب فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Cσηтαcт* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ قفل مخاطب غیرفعال شد🔓"
end
end
end
---------------lock Forward-------------------
local function lock_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_forward = data[tostring(target)]["settings"]["lock_forward"] 
if lock_forward == "yes" then
if not lang then
 return "☆》*Lσcк Fσяωαя∂* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ فوروارد از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Fσяωαя∂* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ فوروارد فعال شد🔐"
end
end
end

local function unlock_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_forward = data[tostring(target)]["settings"]["lock_forward"]
 if lock_forward == "no" then
if not lang then
return "☆》*Lσcк Fσяωαя∂* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓"
elseif lang then
return "☆》قفل ↫ فوروارد فعال نیست🔓"
end 
else 
data[tostring(target)]["settings"]["lock_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "☆》*Lσcк Fσяωαя∂* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ فوروارد غیرفعال شد🔓"
end
end
end
---------------lock Location-------------------
local function lock_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_location = data[tostring(target)]["settings"]["lock_location"] 
if lock_location == "yes" then
if not lang then
 return "☆》*Lσcк Lσcαтιση* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ موقعیت  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "☆》*Lσcк Lσcαтιση* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ موقعیت فعال شد🔐"
end
end
end

local function unlock_location(msg, data, target)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_location = data[tostring(target)]["settings"]["lock_location"]
 if lock_location == "no" then
if not lang then
return "☆》*Lσcк Lσcαтιση* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ موقعیت فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Lσcαтιση* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ موقعیت غیرفعال شد🔓"
end
end
end
---------------lock Document-------------------
local function lock_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_document = data[tostring(target)]["settings"]["lock_document"] 
if lock_document == "yes" then
if not lang then
 return "☆》*Lσcк Dσcυмєηт* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ فایل  از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Dσcυмєηт* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
 return "☆》قفل ↫ فایل فعال شد🔐"
end
end
end

local function unlock_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end
end 

local lock_document = data[tostring(target)]["settings"]["lock_document"]
 if lock_document == "no" then
if not lang then
return "☆》*Lσcк Dσcυмєηт* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓" 
elseif lang then
return "☆》قفل ↫ فایل فعال نیست🔓"
end
else 
data[tostring(target)]["settings"]["lock_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк Dσcυмєηт* _Hαѕ Bєєη Dιѕαвℓє∂_🔓" 
else
return "☆》قفل ↫ فایل غیرفعال شد🔓"
end
end
end
---------------lock TgService-------------------
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "yes" then
if not lang then
 return "☆》*Lσcк TgSєяνιcє* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل ↫ خدمات تلگرام از قبل فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк TgSєяνιcє* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
return "☆》قفل ↫ خدمات تلگرام  فعال شد🔐"
end
end
end

local function unlock_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"]
 if lock_tgservice == "no" then
if not lang then
return "☆》*Lσcк TgSєяνιcє* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓"
elseif lang then
return "☆》قفل ↫ خدمات تلگرام فعال نیست🔓"
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк TgSєяνιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔓"
else
return "☆》قفل ↫ خدمات تلگرام  غیرفعال شد🔓🔓"
end 
end
end

---------------lock Keyboard-------------------
local function lock_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"] 
if lock_keyboard == "yes" then
if not lang then
 return "☆》*Lσcк Kєувσαя∂* _Iѕ Aℓяєα∂у Eηαвℓє∂_🔐"
elseif lang then
 return "☆》قفل صفحه کلید فعال است🔐"
end
else
 data[tostring(target)]["settings"]["lock_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "☆》*Lσcк Kєувσαя∂* _Hαѕ Bєєη Eηαвℓє∂_🔐"
else
return "☆》قفل صفحه کلید فعال شد🔐"
end
end
end

local function unlock_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️"
else
return "↫●_شما مدیر ربات نیستید_‼️"
end 
end

local lock_keyboard = data[tostring(target)]["settings"]["lock_keyboard"]
 if lock_keyboard == "no" then
if not lang then
return "☆》*Lσcк Kєувσαя∂* _Iѕ Aℓяєα∂у Dιѕαвℓє∂_🔓"
elseif lang then
return "☆》قفل صفحه کلید غیرفعال است🔓"
end 
else 
data[tostring(target)]["settings"]["lock_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "☆》*Lσcк TgSєяνιcє* _Hαѕ Bєєη Dιѕαвℓє∂_🔓"
else
return "☆》قفل صفحه کلید غیرفعال شد🔓🔓"
end 
end
end
----------Settings---------
local function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "● ➢*Yσυ αяє ησт вσт α∂мιη*‼️" 
else
 return "↫●_شما مدیر ربات نیستید_‼️"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["emoji"] then			
data[tostring(target)]["settings"]["emoji"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_persian"] then			
data[tostring(target)]["settings"]["lock_persian"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["english"] then			
data[tostring(target)]["settings"]["english"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["views"] then			
data[tostring(target)]["settings"]["views"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["ads"] then			
data[tostring(target)]["settings"]["ads"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["fosh"] then			
data[tostring(target)]["settings"]["fosh"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 
  if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_tabchi"] then			
 data[tostring(target)]["settings"]["lock_tabchi"] = "no"		
 end
 end
 
local data = load_data(_config.moderation.data)
local target = msg.to.id
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_all"] then			
data[tostring(target)]["settings"]["lock_all"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_gif"] then			
data[tostring(target)]["settings"]["lock_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_text"] then			
data[tostring(target)]["settings"]["lock_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_photo"] then			
data[tostring(target)]["settings"]["lock_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_video"] then			
data[tostring(target)]["settings"]["lock_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_audio"] then			
data[tostring(target)]["settings"]["lock_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_voice"] then			
data[tostring(target)]["settings"]["lock_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_sticker"] then			
data[tostring(target)]["settings"]["lock_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_contact"] then			
data[tostring(target)]["settings"]["lock_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_forward"] then			
data[tostring(target)]["settings"]["lock_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_location"] then			
data[tostring(target)]["settings"]["lock_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_document"] then			
data[tostring(target)]["settings"]["lock_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tgservice"] then			
data[tostring(target)]["settings"]["lock_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_inline"] then			
data[tostring(target)]["settings"]["lock_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_game"] then			
data[tostring(target)]["settings"]["lock_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_keyboard"] then			
data[tostring(target)]["settings"]["lock_keyboard"] = "no"		
end
end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
if not lang then
local settings = data[tostring(target)]["settings"] 
 text ="*⚙gяσυρ ѕєттιηgѕ:*\n● 》*ℓσcк є∂ιт :* "..settings.lock_edit.."\n● 》*ℓσcк ℓιηкѕ :* "..settings.lock_link.."\n● 》*ℓσcк тαgѕ :* "..settings.lock_tag.."\n● 》*ℓσcк ƒℓσσ∂ :* "..settings.flood.."\n● 》*ℓσcк ѕραм :* "..settings.lock_spam.."\n● 》*ℓσcк мєηтιση :* "..settings.lock_mention.."\n● 》*ℓσcк αяαвιc :* "..settings.lock_persian.."\n● 》*ℓσcк ωєвραgє :* "..settings.lock_webpage.."\n● 》*ℓσcк мαяк∂σωη :* "..settings.lock_markdown.."\n● 》*ℓσcк єηgℓιѕн :* "..settings.english.."\n● 》*ℓσcк ƒσѕн :* "..settings.fosh.."\n● 》*ℓσcк α∂ѕ :* "..settings.ads.."\n● 》*ℓσcк νιєωѕ :* "..settings.views.."\n● 》*ℓσcк ємσנι :* "..settings.emoji.."\n● 》*gяσυρ ωєℓcσмє :* "..settings.welcome.."\n● 》*ℓσcк ριη мєѕѕαgє :* "..settings.lock_pin.."\n● 》*ℓσcк tabchi :* "..settings.lock_tabchi.."\n● 》*вσтѕ ρяσтєcтιση :* "..settings.lock_bots.."\n*● 》ƒℓσσ∂ ѕєηѕιтινιту:* *"..NUM_MSG_MAX.."*\n*____________________*\n*⚙gяσυρ ℓσcк ℓιѕт* :\n● 》*ℓσcк αℓℓ : * "..settings.lock_all.."\n● 》*ℓσcк gιƒ :* "..settings.lock_gif.."\n● 》*ℓσcк тєχт :* "..settings.lock_text.."\n● 》*ℓσcк ιηℓιηє :* "..settings.lock_inline.."\n● 》*ℓσcк gαмє :* "..settings.lock_game.."\n● 》*ℓσcк ρнσтσ :* "..settings.lock_photo.."\n● 》*ℓσcк νι∂єσ :* "..settings.lock_video.."\n● 》*ℓσcк αυ∂ισ :* "..settings.lock_audio.."\n● 》*ℓσcк νσιcє :* "..settings.lock_voice.."\n● 》*ℓσcк ѕтιcкєя :* "..settings.lock_sticker.."\n● 》*ℓσcк cσηтαcт :* "..settings.lock_contact.."\n● 》*ℓσcк ƒσяωαя∂ :* "..settings.lock_forward.."\n● 》*ℓσcк ℓσcαтιση :* "..settings.lock_location.."\n● 》*ℓσcк ∂σcυмєηт :* "..settings.lock_document.."\n● 》*ℓσcк тgѕєяνιcє :* "..settings.lock_tgservice.."\n● 》*ℓσcк кєувσαя∂ :* "..settings.lock_keyboard.."\n*____________________*\n*🌐gяσυρ ℓαηgυαgє* : єη\n🗓*єχριя:* _"..expire_date.."_\n*✒ѕυ∂σ вσт:* @bombangteam\n*Channel:* @MaTaDoRTeaM"
else
local exp = redis:get("charged:"..msg.chat_id_)
    local day = 86400
    local ex = redis:ttl("charged:"..msg.chat_id_)
       if not exp or ex == -1 then
        expirefa = " نامحدود"
       else
        local d = math.floor(ex / day ) + 1
       expirefa = " *"..d.."* _روز_"
   end
local settings = data[tostring(target)]["settings"] 
 text = "*تنظیمات گروه:*\n*●》قفل ویرایش :* "..settings.lock_edit.."\n*●》قفل لینک :* "..settings.lock_link.."\n*●》قفل تگ :* "..settings.lock_tag.."\n*●》قفل فلود :* "..settings.flood.."\n*●》قفل اسپم :* "..settings.lock_spam.."\n*●》قفل فراخوانی :* "..settings.lock_mention.."\n*●》قفل عربی :* "..settings.lock_persian.."\n*●》قفل وب :* "..settings.lock_webpage.."\n*●》قفل فونت :* "..settings.lock_markdown.."\n*●》قفل انگلیسی :* "..settings.english.."\n*●》قفل فحش: * "..settings.fosh.."\n*●》قفل تبلیغات:* "..settings.ads.."\n*●》قفل ویو:* "..settings.views.."\n*●》قفل اموجی:* "..settings.emoji.."\n*●》پیام خوشآمد گویی :* "..settings.welcome.."\n*●》قفل سنجاق :* "..settings.lock_pin.."\n*●》قفل تبچی :* "..settings.lock_tabchi.."\n*●》قفل ربات :* "..settings.lock_bots.."\n*●》تنظیم فلود :* *"..NUM_MSG_MAX.."*\n*●》قفل همه : * "..settings.lock_all.."\n*●》قفل گیف :* "..settings.lock_gif.."\n*●》قفل متن :* "..settings.lock_text.."\n*●》قفل اینلاین :* "..settings.lock_inline.."\n*●》قفل بازی :* "..settings.lock_game.."\n*●》قفل عکس :* "..settings.lock_photo.."\n*●》قفل فیلم :* "..settings.lock_video.."\n*●》قفل اهنگ :* "..settings.lock_audio.."\n*●》قفل صدا :* "..settings.lock_voice.."\n*●》قفل استیکر :* "..settings.lock_sticker.."\n*●》قفل مخاطب :* "..settings.lock_contact.."\n*●》قفل فوروارد :* "..settings.lock_forward.."\n*●》قفل موقعیت :* "..settings.lock_location.."\n*●》قفل فایل :* "..settings.lock_document.."\n*●》قفل خدمات تلگرام :* "..settings.lock_tgservice.."\n*●》قفل کیبورد :* "..settings.lock_keyboard.."\n*____________________*\n🌐_زبان سوپرگروه_ : *فارسی*\n🗓*میزان شارژ گروه: * _"..expire_date.."_\n✒*برنامه نویس:* @mafia_boy\n*Channel:* @bombangteam"
end
if not lang then
text = string.gsub(text, "yes", "#ყεร ✔")
text = string.gsub(text, "no", "#ησ ✖")
text =  string.gsub(text, "0", "⓪")
text =  string.gsub(text, "1", "➀")
text =  string.gsub(text, "2", "➁")
text =  string.gsub(text, "3", "➂")
text =  string.gsub(text, "4", "➃")
text =  string.gsub(text, "5", "➄")
text =  string.gsub(text, "6", "➅")
text =  string.gsub(text, "7", "➆")
text =  string.gsub(text, "8", "➇")
text =  string.gsub(text, "9", "➈")
 else
 text = string.gsub(text, "yes", "#فعال ✔")
 text =  string.gsub(text, "no", "#غیرفعال ✖")
 end

return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "id" or matches[1]=="آیدی" or matches[1]=="Id" or matches[1]=="ایدی"then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
 if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'شناسه گروه : '..msg.to.id..'\nشناسه شما : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
end
	   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)	
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "pin" and is_mod(msg) and msg.reply_id  or matches[1] == "سنجاق" and is_mod(msg) and msg.reply_id or matches[1] == "Pin" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Mєѕѕαgє Hαѕ Bєєη Pιηηє∂*"
elseif lang then
return "_پیام سجاق شد_✅"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Mєѕѕαgє Hαѕ Bєєη Pιηηє∂*"
elseif lang then
return "_پیام سجاق شد_✅"
end
end
end
if matches[1] == 'unpin' and is_mod(msg) or matches[1] == 'حذف سنجاق' and is_mod(msg) or matches[1] == 'Unpin' and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pιη мєѕѕαgє нαѕ вєєη υηριηηє∂*"
elseif lang then
return "پیام سنجاق شده پاک شد✅"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pιη мєѕѕαgє нαѕ вєєη υηριηηє∂*"
elseif lang then
return "پیام سنجاق شده پاک شد✅"
end
end
end
if matches[1] == "add" or  matches[1] == "نصب" or matches[1] == "Add" then
return modadd(msg)
end
if matches[1] == "rem" or matches[1] == "لغو نصب" or matches[1] == "Rem" then
return modrem(msg)
end
if matches[1] == "setowner" and is_admin(msg) or  matches[1] == "تنظیم مدیر" and is_admin(msg) or matches[1] == "Setowner" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" and is_admin(msg) or matches[1] == "حذف مدیر" and is_admin(msg) or matches[1] == "Remowner" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "promote" and is_owner(msg) or matches[1] == "تنظیم ادمین" and is_owner(msg) or matches[1] == "Promote" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "demote" and is_owner(msg) or  matches[1] == "حذف ادمین" and is_owner(msg) or matches[1] == "Demote" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "lock" and is_mod(msg) or  matches[1] == "قفل" and is_mod(msg) or matches[1] == "Lock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link" or matches[2]=="لینک" then
return lock_link(msg, data, target)
end
if matches[2] == "tag"  or matches[2]=="تگ" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention"  or matches[2]=="فراخوانی" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic"  or matches[2]=="عربی" then
return lock_persian(msg, data, target)
end
if matches[2] == "edit"  or matches[2]=="ویرایش" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam"  or matches[2]=="اسپم" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood"  or matches[2]=="فلود" then
return lock_flood(msg, data, target)
end
if matches[2] == "bots"  or matches[2]=="ربات" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" or matches[2]=="مارکدون" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage"  or matches[2]=="وب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg)  or matches[2]=="سنجاق" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "english"  or matches[2]=="انگلیسی"  then
return lock_english(msg, data, target)
end
if matches[2] == "views"  or matches[2]=="ویو" then
return lock_views(msg, data, target)
end
if matches[2] == "emoji"  or matches[2]=="ایموجی" then
return lock_emoji(msg, data, target)
end
if matches[2] == "fosh"  or matches[2]=="فحش" then
return lock_fosh(msg, data, target)
end
if matches[2] == "ads"  or matches[2]=="تبلیغات" then
return lock_ads(msg, data, target)
end
if matches[2] == "tabchi" and is_owner(msg) or matches[2] == "Tabchi" and is_owner(msg) or matches[2] == "تبچی" and is_owner(msg)  then
return lock_tabchi(msg, data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) or matches[1]=="بازکردن" and is_mod(msg) or matches[1] == "Unlock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link"  or matches[2]=="لینک" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag"  or matches[2]=="تگ" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention"  or matches[2]=="فراخوانی" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic"  or matches[2]=="عربی" then
return unlock_persian(msg, data, target)
end
if matches[2] == "edit"  or matches[2]=="ویرایش" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam"  or matches[2]=="اسپم" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2]=="فلود" then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots"  or matches[2]=="ربات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown"  or matches[2]=="مارکدون" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2]=="وب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg)  or matches[2]=="سنجاق" and is_owner(msg)  then
return unlock_pin(msg, data, target)
end
if matches[2] == "english" or matches[2]=="انگلیسی"  then
return unlock_english(msg, data, target)
end
if matches[2] == "views" or matches[2]=="ویو" then
return unlock_views(msg, data, target)
end
if matches[2] == "emoji" or matches[2]=="ایموجی" then
return unlock_emoji(msg, data, target)
end
if matches[2] == "fosh"  or matches[2]=="فحش" then
return unlock_fosh(msg, data, target)
end
if matches[2] == "ads"  or matches[2]=="تبلیغات" then
return unlock_ads(msg, data, target)
end
if matches[2] == "tabchi" and is_owner(msg) or matches[2] == "Tabchi" and is_owner(msg) or matches[2] == "تبچی" and is_owner(msg)  then
return unlock_tabchi(msg, data, target)
end
end

if matches[1] == "lock" and is_mod(msg) or matches[1]== "قفل" and is_mod(msg) or matches[1] == "lock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "all"  or matches[2]=="همه" then
return lock_all(msg, data, target)
end
if matches[2] == "gif"  or matches[2]=="گیف" then
return lock_gif(msg, data, target)
end
if matches[2] == "text"  or matches[2]=="متن" then
return lock_text(msg ,data, target)
end
if matches[2] == "photo"  or matches[2]=="عکس" then
return lock_photo(msg ,data, target)
end
if matches[2] == "video"  or matches[2]=="ویدیو" then
return lock_video(msg ,data, target)
end
if matches[2] == "audio"  or matches[2]=="اهنگ" then
return lock_audio(msg ,data, target)
end
if matches[2] == "voice"  or matches[2]=="صدا" then
return lock_voice(msg ,data, target)
end
if matches[2] == "sticker"  or matches[2]=="استیکر" then
return lock_sticker(msg ,data, target)
end
if matches[2] == "contact"  or matches[2]=="مخاطب" then
return lock_contact(msg ,data, target)
end
if matches[2] == "forward"  or matches[2]=="فوروارد" then
return lock_forward(msg ,data, target)
end
if matches[2] == "location"  or matches[2]=="مکان" then
return lock_location(msg ,data, target)
end
if matches[2] == "document"  or matches[2]=="فایل" then
return lock_document(msg ,data, target)
end
if matches[2] == "tgservice"  or matches[2]=="سرویس تلگرام" then
return lock_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="اینلاین" then
return lock_inline(msg ,data, target)
end
if matches[2] == "game"  or matches[2]=="بازی" then
return lock_game(msg ,data, target)
end
if matches[2] == "keyboard"  or matches[2]=="کیبورد" then
return lock_keyboard(msg ,data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) or matches[1]=="بازکردن" and is_mod(msg) or matches[1] == "Unlock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "all"  or matches[2]=="همه" then
return unlock_all(msg, data, target)
end
if matches[2] == "gif"  or matches[2]=="گیف"then
return unlock_gif(msg, data, target)
end
if matches[2] == "text" or matches[2]=="متن" then
return unlock_text(msg, data, target)
end
if matches[2] == "photo" or matches[2]=="عکس" then
return unlock_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2]=="ویدیو" then
return unlock_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2]=="اهنگ" then
return unlock_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2]=="صدا" then
return unlock_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2]=="استیکر" then
return unlock_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2]=="مخاطب" then
return unlock_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2]=="فوروارد" then
return unlock_forward(msg ,data, target)
end
if matches[2] == "location"  or matches[2]=="مکان" then
return unlock_location(msg ,data, target)
end
if matches[2] == "document"  or matches[2]=="فایل" then
return unlock_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2]=="سرویس تلگرام" then
return unlock_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="اینلاین" then
return unlock_inline(msg ,data, target)
end
if matches[2] == "game"  or matches[2]=="بازی" then
return unlock_game(msg ,data, target)
end
if matches[2] == "keyboard"   or matches[2]=="کیبورد" then
return unlock_keyboard(msg ,data, target)
end
end
if matches[1] == "gpinfo" and is_mod(msg) and msg.to.type == "channel" or matches[1] == "اطلاعات گروه" and is_mod(msg) and msg.to.type == "channel" or matches[1] == "Gpinfo" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Gяσυρ Iηƒσ :*\n👤_A∂мιη Cσυηт :_ *"..data.administrator_count_.."*\n👥_Mємвєя Cσυηт :_ *"..data.member_count_.."*\n_Kιcкє∂ Cσυηт :_ *"..data.kicked_count_.."*\n_Gяσυρ ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'newlink' and is_mod(msg) or  matches[1] == 'لینک جدید' and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bσт ιѕ ησт gяσυρ cяєαтσя_\n_ѕєт α ℓιηк  σя ƒσя gяσυρ ωιтн υѕιηg_ /setlink or تنظیم لینک", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/  _یا تنظیم لینک لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Nєωℓιηк Cяєαтє∂*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_", 1, 'md')
     end
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if matches[1] == 'setlink' and is_owner(msg) or matches[1] == 'تنظیم لینک' and is_owner(msg) or matches[1] == 'Setlink' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لینک جدید ذخیره شد"
		 	end
       end
		end
    if matches[1] == 'link' and (msg) or  matches[1] == 'لینک' and (msg) or matches[1] == 'Link' and (msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
       if not lang then
        return "_Fιяѕт cяєαтє α ℓιηк ƒσя gяσυρ ωιтн υѕιηg_ /newlink or {لینک جدید} \n_Iƒ вσт ησт gяσυρ cяєαтσя ѕєт α ℓιηк ωιтн υѕιηg_ /setlink or {تنظیم لینک}"
     else
        return "ابتدا با دستور newlink/ یا {لینک جدید} لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ یا {تنظیم لینک} لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>Gяσυρ Lιηк :</b>\n"..linkgp
     else
      text = "<b>لینک گروه :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
if matches[1] == 'linkpv' and is_mod(msg) or matches[1] == 'Linkpv' and is_mod(msg) or matches[1] == 'لینک پیوی' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
      if not lang then
        return "*Group Link Was Send In Your Private Message*"
       else
        return "_لینک گروه به چت خصوصی شما ارسال شد_"
        end
     end
  if matches[1] == "setrules" and matches[2] and is_mod(msg) or matches[1] == "تنظیم قوانین" and matches[2] and is_mod(msg) or matches[1] == "Setrules" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if matches[1] == "rules" or matches[1] == "قوانین" or matches[1] == "Rules" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹRυℓєѕ :\n1 *Nσ Fℓσσ∂*.\n2 *Nσ Sραм*.\n3 *Nσ A∂νєятιѕιηg*.\n4 *Tяу тσ ѕтαу ση тσριc*.\n5 *Fσявι∂∂єη αηу яαcιѕт, ѕєχυαℓ, нσмσρнσвιc σя gσяє cσηтєηт*.\n➡ *Rєρєαтє∂ ƒαιℓυяє тσ cσмρℓу ωιтн тнєѕє яυℓєѕ ωιℓℓ cαυѕє вαη.*\n@MaTaDoRTeaM"
    elseif lang then
       rules = "ℹ_قوانین :_\n1 _ارسال پیام مکرر ممنوع._\n2 _اسپم ممنوع_.\n3 _تبلیغ ممنوع_.\n4 _سعی کنید از موضوع خارج نشید_.\n5 _هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع_ .\n⬅️ _از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود_.\n@MaTaDoRTeaM"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" and matches[2] and is_mod(msg) or matches[1] == "Res" and matches[2] and is_mod(msg) or matches[1] == "رس" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" and matches[2] and is_mod(msg) or matches[1] == "Whois" and matches[2] and is_mod(msg) or matches[1] == "شخص" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'setflood' and is_mod(msg) or matches[1] == 'تنظیم فلود' and is_mod(msg) or matches[1] == 'Setflood' and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 200 then
				return "_Wrong number, range is_ *[1-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
       end
		if matches[1]:lower() == 'clean' and is_owner(msg) or matches[1]:lower() == 'پاک کردن' and is_owner(msg) or matches[1]:lower() == 'Clean' and is_owner(msg) then
			if matches[2] == 'mods' or  matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
          return "_Nσ_ *мσ∂єяαтσяѕ* _ιη тнιѕ gяσυρ_"
             else
                return "هیچ مدیری برای ربات در این گروه انتخاب نشده است"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
        return "_Aℓℓ_ *мσ∂єяαтσяѕ* _нαѕ вєєη ∂ємσтє∂_"
          else
            return "تمام مدیران ربات در گروه تنزیل مقام شدند"
			end
         end
			if matches[2] == 'filterlist' or matches[2] == 'لیست فیلتر' or matches[2] == 'Filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
          return "*Fιℓтєяє∂ ωσя∂ѕ ℓιѕт* _ιѕ ємρту_"
         else
          return "_لیست کلمات فیلتر شده خالی است_"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
        return "*Fιℓтєяє∂ ωσя∂ѕ ℓιѕт* _нαѕ вєєη cℓєαηє∂_"
           else
        return "_لیست کلمات فیلتر شده پاک شد_"
           end
			end
			if matches[2] == 'rules' or matches[2] == 'قوانین' or matches[2] == 'Rules' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
          return "_Nσ_ *яυℓєѕ* _αναιℓαвℓє_"
             else
               return "قوانین برای گروه ثبت نشده است"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
        return "*Gяσυρ яυℓєѕ* _нαѕ вєєη cℓєαηє∂_"
          else
            return "قوانین گروه پاک شد"
			end
       end
			if matches[2] == 'welcome' or  matches[2] == 'ولکام' or matches[2] == 'Welcome' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					        return "*Wєℓcσмє Mєѕѕαgє ησт ѕєт*"
             else
               return "پیام خوشآمد گویی ثبت نشده است"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
        return "*Wєℓcσмє мєѕѕαgє* _нαѕ вєєη cℓєαηє∂_"
          else
            return "پیام خوشآمد گویی پاک شد"
			end
       end
			if matches[2] == 'about'  or matches[2] == 'درباره گروه' or matches[2] == 'About' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
          return "_Nσ_ *∂єѕcяιρтιση* _αναιℓαвℓє_"
            else
              return "پیامی مبنی بر درباره گروه ثبت نشده است"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
        return "*Gяσυρ ∂єѕcяιρтιση* _нαѕ вєєη cℓєαηє∂_"
           else
              return "پیام مبنی بر درباره گروه پاک شد"
             end
		   	end
        end
		if matches[1]:lower() == 'clean' and is_admin(msg) or matches[1]:lower() == 'پاک کردن' and is_admin(msg) or matches[1]:lower() == 'Clean' and is_admin(msg) then
			if matches[2] == 'owners' or matches[2] == 'مدیر' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
          return "_Nσ_ *σωηєяѕ* _ιη тнιѕ gяσυρ_"
            else
                return "مدیری برای گروه انتخاب نشده است"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
		     return "_Aℓℓ_ *σωηєяѕ* _нαѕ вєєη ∂ємσтє∂_"
           else
            return "تمامی مدیران گروه تنزیل مقام شدند"
          end
			end
     end
if matches[1] == "setname" and matches[2] and is_mod(msg) or matches[1] == "تنظیم نام" and matches[2] and is_mod(msg) or matches[1] == "Setname" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "setabout" and matches[2] and is_mod(msg) or  matches[1] == "تنظیم درباره گروه" and matches[2] and is_mod(msg) or matches[1] == "Setabout" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Gяσυρ ∂єѕcяιρтιση* _нαѕ вєєη ѕєт_"
    else
     return "پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if matches[1] == "about" and msg.to.type == "chat" or matches[1] == "درباره گروه" and msg.to.type == "chat" or matches[1] == "About" and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_Nσ_ *∂єѕcяιρтιση* _αναιℓαвℓє_"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'filter' and is_mod(msg) or matches[1] == 'فیلتر' and is_mod(msg) or  matches[1] == 'Filter' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unfilter' and is_mod(msg) or matches[1] == 'حذف فیلتر' and is_mod(msg) or matches[1] == 'Unfilter' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'filterlist' and is_mod(msg) or  matches[1] == 'لیست فیلتر' and is_mod(msg) or matches[1] == 'Filterlist' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "settings" or matches[1] == "تنظیمات" or matches[1] == "Settings" then
return group_settings(msg, target)
end
if matches[1] == "modlist" or matches[1] == "لیست ادمین" or matches[1] == "Modlist" then
return modlist(msg)
end
if matches[1] == "ownerlist" and is_owner(msg) or  matches[1] == "لیست مدیران" and is_owner(msg) or matches[1] == "Ownerlist" and is_owner(msg)  then
 return ownerlist(msg)
end

if matches[1] == "setlang" and is_owner(msg) or matches[1] == "تنظیم زبان" and is_owner(msg) or matches[1] == "Setlang" and is_owner(msg) then
   if matches[2] == "en" or matches[2] == "انگلیسی" then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Gяσυρ Lαηgυαgє Sєт Tσ:_ EN✅"
  elseif matches[2] == "fa" or matches[2] == "فارسی" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"
end
end


if matches[1] == "help" and is_mod(msg) or matches[1] == "Help" and is_mod(msg) or matches[1] == "راهنما" and is_mod(msg) then
if not lang then
text = [[
⚜*BOMBANGHELP*
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔶 !mod help
⚙️》راهنما مدریت
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔷 !lock help1
⚙️》راهنما قفل1
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔶 !lock help2
⚙️》راهنما قفل2
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔷 !fun help
⚙️》راهنما سرگرمی
︻︻︻︻︻︻︻︻︻︻︻︻︻
‼️ توجه ‼️
دستورات هم انگلیسی هستند هم فارسی میتوانید بنویسید 👇

 راهنما قفل   👉👈  lock help!   
︻︻︻︻︻︻︻︻︻︻︻︻︻
🌐 @bom_bang_team 🌐

*> LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , fa]`

*___________________________*
*🎭Pwered By :* @bombangteam				
*___________________________*
]]
elseif lang then
text = [[
⚜*BOMBANGHELP*
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔶 !mod help
⚙️》راهنما مدریت
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔷 !lock help1
⚙️》راهنما قفل1
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔶 !lock help2
⚙️》راهنما قفل2
︻︻︻︻︻︻︻︻︻︻︻︻︻
🔷 !fun help
⚙️》راهنما سرگرمی
︻︻︻︻︻︻︻︻︻︻︻︻︻
‼️ توجه ‼️
دستورات هم انگلیسی هستند هم فارسی میتوانید بنویسید 👇

 راهنما قفل   👉👈  lock help!   
︻︻︻︻︻︻︻︻︻︻︻︻︻
🌐 @bom_bang_team 🌐

*> LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , fa]`

*___________________________*
*support :* @bombangteam				
*___________________________*
]]
end
return text
end

if matches[1] == "sudohelp" and is_mod(msg) or  matches[1] == "Sudohelp" and is_mod(msg) or  matches[1] == "راهنمای سودو" and is_mod(msg) then
text = [[
⚜*мαTdσя TG*

*Visudo* `[username|id|reply]`
🔹_اضافه کردن سودو_

*Desudo* `[username|id|reply]`
🔸_حذف کردن سودو_

*Sudolist* 
🔹_لیست سودو‌های ربات_

*Adminprom* `[username|id|reply]`
🔸_اضافه کردن ادمین به ربات_

*Admindem* `[username|id|reply]`
🔹_حذف فرد از ادمینی ربات_

*Adminlist* 
🔸_لیست ادمین ها_

*Leave* 
🔹_خارج شدن ربات از گروه_

*Autoleave* `[disable/enable]`
🔸_خروج خودکار_

*Creategroup* `[text]`
🔹_ساخت گروه ریلم_

*Createsuper* `[text]`
🔸_ساخت سوپر گروه_

*Tosuper* 
🔹_تبدیل به سوپر گروه_

*Chats*
🔸_لیست گروه های مدیریتی ربات_

*Join* `[id]`
🔹_جوین شدن توسط ربات_

*Rem* `[id]`
🔸_حذف گروه ازطریق پنل مدیریتی_

*Import* `[link]`
🔹_جوین شدن ربات توسط لینک_

*Setbotname* `[text]`
🔸_تغییر اسم ربات_

*Setbotusername* `[text]`
🔹_تغییر یوزرنیم ربات_

*Delbotusername* 
🔸_پاک کردن یوزرنیم ربات_

*Markread* `[off/on]`
🔹_تیک دوم_

*Broadcast* `[text]`
🔸_فرستادن پیام به تمام گروه های مدیریتی ربات_

*Bc* `[text]` `[gpid]`
🔹_ارسال پیام مورد نظر به گروه خاص_

*Sendfile* `[cd]` `[file]`
🔸_ارسال فایل موردنظر از پوشه خاص_

*Sendplug* `[plug]`
🔹_ارسال پلاگ مورد نظر_

*Save* `[plugin name] [reply]`
🔸_ذخیره کردن پلاگین_

*Savefile* `[address/filename] [reply]`
🔹_ذخیره کردن فایل در پوشه مورد نظر_

*Clear cache*
🔸_پاک کردن کش مسیر .telegram-cli/data_

*Check*
🔹_اعلام تاریخ انقضای گروه_

*Check* `[GroupID]`
🔸_اعلام تاریخ انقضای گروه مورد نظر_

*Charge* `[GroupID]` `[Number Of Days]`
🔹_تنظیم تاریخ انقضای گروه مورد نظر_

*Charge* `[Number Of Days]`
🔸_تنظیم تاریخ انقضای گروه_

*Jointo* `[GroupID]`
🔹_دعوت شدن شما توسط ربات به گروه مورد نظر_

*Leave* `[GroupID]`
🔸_خارج شدن ربات از گروه مورد نظر_

🍃*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

⚡_این راهنما فقط برای سودو ها/ادمین های ربات میباشد!_

⚠`این به این معناست که فقط سودو ها/ادمین های ربات میتوانند از دستورات بالا استفاده کنند!`

*موفق باشید ;)*

*___________________________*
*support :* @bombangteam			
*___________________________*
]]
return text
end

if matches[1] == "lockhelp1" and is_mod(msg) or matches[1] == "Lockhelp1" and is_mod(msg) or matches[1] == "راهنماقفل1" and is_mod(msg) then
if not lang then
text = [[
💠*LOCK HELP1 :*
🔐راهنما قفل1🔐
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل لینک 
🔸بازکردن لینک
🔹lock link
🔸unlock link
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل تگ
🔸بازکردن تگ
🔹lock tag
🔸unlock tag
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ویرایش
🔸بازکردن ویرایش
🔹lock edit
🔸unlock edit
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فحش
🔸بازکردن فحش
🔹 lock fosh
🔸 unlock fosh
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فارسی
🔸بازکردن فارسی
🔹lock arabic
🔸unlock arabic
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل وبسایت ها
🔸بازکردن وبسایت ها
🔹lock webpage
🔸unlock webpage
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ربات
🔸بازکردن ربات 
🔹lock bots
🔸unlock bots
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل اسپم
🔸بازکردن اسپم
🔹lock spam
🔸unlock spam
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فلود
🔸بازکردن فلود
🔹lock flood
🔸unlock flood
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄ 
🔹قفل  فونت
🔸بازکردن فونت
🔹lock markdown
🔸unlock markdown
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فراخوانی
🔸بازکردن فراخوانی
🔹lock mention 
🔸unlock mention
*___________________________*
*support :* @bombangteam				
*___________________________*
 ]]
 elseif lang then
 text = [[
💠*LOCK HELP1 :*
🔐راهنما قفل1🔐
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل لینک 
🔸بازکردن لینک
🔹lock link
🔸unlock link
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل تگ
🔸بازکردن تگ
🔹lock tag
🔸unlock tag
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ویرایش
🔸بازکردن ویرایش
🔹lock edit
🔸unlock edit
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فحش
🔸بازکردن فحش
🔹 lock fosh
🔸 unlock fosh
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فارسی
🔸بازکردن فارسی
🔹lock arabic
🔸unlock arabic
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل وبسایت ها
🔸بازکردن وبسایت ها
🔹lock webpage
🔸unlock webpage
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ربات
🔸بازکردن ربات 
🔹lock bots
🔸unlock bots
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل اسپم
🔸بازکردن اسپم
🔹lock spam
🔸unlock spam
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فلود
🔸بازکردن فلود
🔹lock flood
🔸unlock flood
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄ 
🔹قفل  فونت
🔸بازکردن فونت
🔹lock markdown
🔸unlock markdown
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فراخوانی
🔸بازکردن فراخوانی
🔹lock mention 
🔸unlock mention
*___________________________*
*support :* @bombangteam				
*___________________________*
]]
end
return text
end

if matches[1] == "lockhelp2" and is_mod(msg) or matches[1] == "Lockhelp2" and is_mod(msg) or matches[1] == "راهنماقفل2" and is_mod(msg) then
if not lang then
text = [[
💠*LOCK HELP2 :*
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل گیف
🔸 باز کردن گیف
🔹 !lock gif
🔸 !unlock gif
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل عکس
🔸 باز کردن عکس
 🔹 !lock photo
🔸  !unlock photo
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فایل
🔸 باز کردن فایل
🔹 !lock document 
🔸 !unlock document
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل استیکر
🔸 باز کردن استیکر
🔹  !lock sticker
🔸 !unlock sticker
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فیلم 
🔸 باز کردن فیلم
🔹 !lock video
🔸 !unlock video
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل متن
🔸 باز کردن متن
🔹 !lock text
🔸 !unlock text
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فروارد
🔸 باز کردن فروارد
🔹  !lock forward
🔸  !unlock forward
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل ویس
🔸 باز کردن ویس
🔹  !lock voice
🔸 !unlock voice
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل اطلاعات تماس
🔸 باز کردن اطلاعات تماس
🔹  !lock contact
🔸 !unlock contact
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل همه 
🔸 باز کردن همه 
🔹 !lock all
🔸 !unlock all
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل  اینلاین
🔸 باز کردن اینلاین
🔹 !lock inline
🔸 !unlock inline
*___________________________*
*support :* @bombangteam				
*___________________________*
 ]]
 elseif lang then
 text = [[
💠*LOCK HELP1 :*
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل لینک 
🔸بازکردن لینک
🔹lock link
🔸unlock link
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل تگ
🔸بازکردن تگ
🔹lock tag
🔸unlock tag
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ویرایش
🔸بازکردن ویرایش
🔹lock edit
🔸unlock edit
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل فحش
🔸بازکردن فحش
🔹 lock fosh
🔸 unlock fosh
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فارسی
🔸بازکردن فارسی
🔹lock arabic
🔸unlock arabic
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل وبسایت ها
🔸بازکردن وبسایت ها
🔹lock webpage
🔸unlock webpage
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل ربات
🔸بازکردن ربات 
🔹lock bots
🔸unlock bots
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹 قفل اسپم
🔸بازکردن اسپم
🔹lock spam
🔸unlock spam
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فلود
🔸بازکردن فلود
🔹lock flood
🔸unlock flood
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄ 
🔹قفل  فونت
🔸بازکردن فونت
🔹lock markdown
🔸unlock markdown
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🔹قفل فراخوانی
🔸بازکردن فراخوانی
🔹lock mention 
🔸unlock mention
*___________________________*
*support :* @bombangteam				
*___________________________*
]]
end
return text
end
if matches[1] == "modhelp" and is_mod(msg) or matches[1] == "Modhelp" and is_mod(msg) or matches[1] == "راهنمامدیریت" and is_mod(msg) then
if not lang then
text = [[
💠*ALL CoMmAnDs :*

🔘🔶راهنما مدیریت🔶🔘
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setowner [username|id|reply] 
🔷 مدیر 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !remowner [username|id|reply] 
 🔶 حذف مدیر  【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !promote [username|id|reply] 
🔷 ادمین 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !demote [username|id|reply] 
🔶 حذف ادمین 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setflood [1-50]
🔷 تنظیم فلود 【50-1】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !silent [username|id|reply] 
🔶 سایلنت 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unsilent [username|id|reply] 
🔷 رفع سایلنت 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !kick [username|id|reply] 
🔶 اخراج 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ban [username|id|reply] 
🔷 مسدود 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unban [username|id|reply] 
🔶 رفع مسدود 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !res [username]
🔷 رس 【نام کاربری】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !id [reply]
🔶 ایدی 【ریپلای】 
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !whois [id]
🔷 چه کسی 【ایدی】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !set[rules | name | photo | link | about ]
🔶 تنظیم 【قوانین | اسم عکس | لینک | درباره گروه 】
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !clean [bans | mods | bots | rules | about | silentlist | filterlist | welcome]   
🔷 پاک کردن 【 لیست مسدود| مدیران| ربات | قوانین | درباره | لیست سایلنت |  لیست فیلتر | ولکام 】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !filter [word]
🔶 فیلتر‌【کلمه مورد نظر】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unfilter [word]
🔷 رفع فیلتر 【کلمه مورد نظر】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !pin [reply]
🔶 سنجاق 【ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unpin [reply]
🔷 حذف سنجاق【ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !welcome enable/disable
🔶 ولکام  [فعال - غیر فعال]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !settings
🔷  تنظیمات
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !silentlist
🔷 لیست سایلنت
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !filterlist
🔶 لیست فیلتر
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !banlist
🔷 لیست مسدود
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ownerlist
🔶 لیست مدیران
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !modlist 
🔷 لیست ادمین ها
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !rules
🔶 قوانین
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !about
🔷  درباره گروه
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !id
🔶 ایدی
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !gpinfo
🔷  اطلاعات گروه
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !link
🔶  لینک 
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setwelcome [text]
🔷 ولکام نصب
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !nerkh
🔷  نرخ
🔶 نمایش قیمت بروز ربات
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !write[text]
🔷  نوشتن(متن)
🔶نوشتن متن به 100 فونت مختلف
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ping
🔶  انلاینی
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
‼️ توجه ‼️
دستورات هم انگلیسی هستند هم فارسی میتوانید بنویسید 👇

 تنظیمات    👉👈   settings!                
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🌐 @bombangteam 🌐
*___________________________*
*support :* @bombangteam				
*___________________________*
]]
elseif lang then
text = [[
💠*ALL CoMmAnDs :*

🔘🔶راهنما مدیریت🔶🔘
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setowner [username|id|reply] 
🔷 مدیر 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !remowner [username|id|reply] 
 🔶 حذف مدیر  【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !promote [username|id|reply] 
🔷 ادمین 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !demote [username|id|reply] 
🔶 حذف ادمین 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setflood [1-50]
🔷 تنظیم فلود 【50-1】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !silent [username|id|reply] 
🔶 سایلنت 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unsilent [username|id|reply] 
🔷 رفع سایلنت 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !kick [username|id|reply] 
🔶 اخراج 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ban [username|id|reply] 
🔷 مسدود 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unban [username|id|reply] 
🔶 رفع مسدود 【نام کاربری | آیدی | ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !res [username]
🔷 رس 【نام کاربری】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !id [reply]
🔶 ایدی 【ریپلای】 
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !whois [id]
🔷 چه کسی 【ایدی】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !set[rules | name | photo | link | about ]
🔶 تنظیم 【قوانین | اسم عکس | لینک | درباره گروه 】
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !clean [bans | mods | bots | rules | about | silentlist | filterlist | welcome]   
🔷 پاک کردن 【 لیست مسدود| مدیران| ربات | قوانین | درباره | لیست سایلنت |  لیست فیلتر | ولکام 】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !filter [word]
🔶 فیلتر‌【کلمه مورد نظر】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unfilter [word]
🔷 رفع فیلتر 【کلمه مورد نظر】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !pin [reply]
🔶 سنجاق 【ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !unpin [reply]
🔷 حذف سنجاق【ریپلای】
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !welcome enable/disable
🔶 ولکام  [فعال - غیر فعال]
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !settings
🔷  تنظیمات
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !silentlist
🔷 لیست سایلنت
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !filterlist
🔶 لیست فیلتر
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !banlist
🔷 لیست مسدود
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ownerlist
🔶 لیست مدیران
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !modlist 
🔷 لیست ادمین ها
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !rules
🔶 قوانین
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !about
🔷  درباره گروه
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !id
🔶 ایدی
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !gpinfo
🔷  اطلاعات گروه
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !link
🔶  لینک 
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !setwelcome [text]
🔷 ولکام نصب
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !nerkh
🔷  نرخ
🔶 نمایش قیمت بروز ربات
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !write[text]
🔷  نوشتن(متن)
🔶نوشتن متن به 100 فونت مختلف
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
✩》 !ping
🔶  انلاینی
﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
‼️ توجه ‼️
دستورات هم انگلیسی هستند هم فارسی میتوانید بنویسید 👇

 تنظیمات    👉👈   settings!                
 ﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄﹃﹄
🌐 @bombangteam 🌐
*___________________________*
*support :* @bombangteam				
*___________________________*
]]
end
return text
end

if matches[1] == "funhelp" and is_mod(msg) or matches[1] == "Funhelp" and is_mod(msg) or matches[1] == "راهنمافان" and is_mod(msg)  then
if not lang then
text = [[
💠*EngliSh CoMmAnDs :*

*Azan* `[name city]`
⚜دریافت اطلاعات اذان شهر مورد نظر

*Info*
🔻دریافت اطلاعات شما

*Me*
⚜دریافت مقام شما در ربات

*Ping*
🔻اطلاع از انلاین بودن ربات

*Time*
⚜دریافت زمان و تاریخ امروز

*Write* `[text]`
🔻نوشتن کلمه با ۱۰۰ فونت مختلف

*Nerkh*
⚜دریافت قیمت ربات جهت خرید

*Weather* `[city]`
🔻دریافت اب وهوا شهر مورد نظر

*Calc* `[number]`
⚜ماشین حساب 

*Tr* `[lang] [word]`
🔻ترجمه متن فارسی به انگلیسی وبرعکس
_مثال:_
_Tr en سلام_

*Short* `[link]`
⚜کوتاه کننده لینک

*Voice* `[text]`
🔻تبدیل متن به صدا

*Sticker* `[word]`
⚜تبدیل متن به استیکر

*Photo* `[word]`
🔻تبدیل متن به عکس

*Tosticker* `[reply]`
⚜تبدیل عکس به استیکر

*Tophoto* `[reply]`
🔻تبدیل استیکر‌ به عکس

 *> LanGuage BoT EngliSh !*
_To Change The LanGuage_ `[Setlang]` `[en , fa]`

*___________________________*
*support :* @bombangteam
*🎭Channel:* @MaTaDoRTeaM				
*___________________________*
]]
elseif lang then
text = [[
💠_دستورات فارسی :_

*اذان* [نام شهر]
⚜دریافت اطلاعات اذان شهر مورد نظر

*اطلاعات من*
🔻دریافت اطلاعات شما

*مقام من*
⚜دریافت مقام شما در ربات

*انلاینی*
🔻اطلاع از انلاین بودن ربات

*ساعت*
⚜دریافت زمان و تاریخ امروز

*نوشتن* [متن]
🔻نوشتن کلمه با ۱۰۰ فونت مختلف

*نرخ*
⚜دریافت قیمت ربات جهت خرید

*اب و هوا* `[شهر]`
🔻دریافت اب وهوا شهر مورد نظر

*حساب* `[عدد]`
⚜ماشین حساب 

*ترجمه* `[زبان] [کلمه]`
🔻ترجمه متن فارسی به انگلیسی وبرعکس
_مثال:_
_ترجمه en سلام_

*کوتاه* `[لینک]`
⚜کوتاه کننده لینک

*صدا* `[متن]`
🔻تبدیل متن به صدا

*استیکر* `[کلمه]`
⚜تبدیل متن به استیکر

*عکس* `[کلمه]`
🔻تبدیل متن به عکس

*به استیکر* `[ریپلای]`
⚜تبدیل عکس به استیکر

*به عکس* `[ریپلای]`
🔻تبدیل استیکر‌ به عکس

*> زبان ربات فارسی !*
_برای تغییر زبان_ `[تنظیم زبان]` `[فارسی , انگلسیی]`

*___________________________*
*پشتیبانی :* @bombangteam				
*___________________________*
]]
end
return text
end
--------------------- Welcome -----------------------
	if matches[1] == "welcome" and is_mod(msg) or matches[1] == "Welcome" and is_mod(msg) or matches[1] == "ولکام" and is_mod(msg) then
		if matches[2] == "enable" or matches[2] == "فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome* _is already enabled_"
       elseif lang then
				return "_خوشآمد گویی از قبل فعال بود_"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "_Group_ *welcome* _has been enabled_"
       elseif lang then
				return "_خوشآمد گویی فعال شد_"
          end
			end
		end
		
		if matches[2] == "disable" or matches[2] == "غیر فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
				return "_خوشآمد گویی از قبل فعال نبود_"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "_خوشآمد گویی غیرفعال شد_"
          end
			end
		end
	end
	if matches[1] == "setwelcome" and matches[2] and is_mod(msg) or matches[1] == "Setwelcome" and matches[2] and is_mod(msg) or matches[1] == "تنظیم ولکام" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.to.id
   local user = msg.from.id
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban."
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
-- return msg
 end
return {
patterns ={
"^[!/#]([Ii]d)$",
"^([Ii]d)$",
"^(آیدی)$",
"^(ایدی)$",
"^[!/#]([Ii]d) (.*)$",
"^([Ii]d) (.*)$",
"^(آیدی) (.*)$",
"^(ایدی) (.*)$",
"^[!/#]([Pp]in)$",
"^([Pp]in)$",
"^(سنجاق)$",
"^[!/#]([Uu]npin)$",
"^([Uu]npin)$",
"^(حذف سنجاق)$",
"^[!/#]([Gg]pinfo)$",
"^([Gg]pinfo)$",
"^(اطلاعات گروه)$",
"^[!/#]([Aa]dd)$",
"^([Aa]dd)$",
"^(نصب)$",
"^[!/#]([Rr]em)$",
"^([Rr]em)$",
"^(لغو نصب)$",
"^[!/#]([Ss]etowner)$",
"^([Ss]etowner)$",
"^(تنظیم مدیر)$",
"^[!/#]([Ss]etowner) (.*)$",
"^([Ss]etowner) (.*)$",
"^(تنظیم مدیر)$",
"^[!/#]([Rr]emowner)$",
"^([Rr]emowner)$",
"^(حذف مدیر)$",
"^[!/#]([Rr]emowner) (.*)$",
"^([Rr]emowner) (.*)$",
"^(حذف مدیر) (.*)$",
"^[!/#]([Pp]romote)$",
"^([Pp]romote)$",
"^(تنظیم ادمین)$",
"^[!/#]([Pp]romote) (.*)$",
"^([Pp]romote) (.*)$",
"^(تنظیم ادمین) (.*)$",
"^[!/#]([Dd]emote)$",
"^([Dd]emote)$",
"^(حذف ادمین)$",
"^[!/#]([Dd]emote) (.*)$",
"^([Dd]emote) (.*)$",
"^(حذف ادمین) (.*)$",
"^[!/#]([Mm]odlist)$",
"^([Mm]odlist)$",
"^(لیست ادمین)$",
"^[!/#]([Oo]wnerlist)$",
"^([Oo]wnerlist)$",
"^(لیست مدیران)$",
"^[!/#]([Ll]ock) (.*)$",
"^([Ll]ock) (.*)$",
"^(قفل) (.*)$",
"^[!/#]([Uu]nlock) (.*)$",
"^([Uu]nlock) (.*)$",
"^(بازکردن) (.*)$",
"^[!/#]([Ss]ettings)$",
"^([Ss]ettings)$",
"^(تنظیمات)$",
"^[!/#]([Mm]ute) (.*)$",
"^([Mm]ute) (.*)$",
"^(قفل) (.*)$",
"^[!/#]([Uu]nlock) (.*)$",
"^([Uu]nlock) (.*)$",
"^(بازکردن) (.*)$",
"^[!/#]([Ll]ink)$",
"^([Ll]ink)$",
"^(لینک)$",
"^[!/#]([Ll]inkpv)$",
"^([Ll]inkpv)$",
"^(لینک پیوی)$",
"^[!/#]([Ss]etlink)$",
"^([Ss]etlink)$",
"^(تنظیم لینک)$",
"^[!/#]([Nn]ewlink)$",
"^([Nn]ewlink)$",
"^(لینک جدید)$",
"^[!/#]([Rr]ules)$",
"^([Rr]ules)$",
"^(قوانین)$",
"^[!/#]([Ss]etrules) (.*)$",
"^([Ss]etrules) (.*)$",
"^(تنظیم قوانین) (.*)$",
"^[!/#]([Aa]bout)$",
"^([Aa]bout)$",
"^(درباره گروه)$",
"^[!/#]([Ss]etabout) (.*)$",
"^([Ss]etabout) (.*)$",
"^(تنظیم درباره گروه) (.*)$",
"^[!/#]([Ss]etname) (.*)$",
"^([Ss]etname) (.*)$",
"^(تنظیم نام) (.*)$",
"^[!/#]([Cc]lean) (.*)$",
"^([Cc]lean) (.*)$",
"^(پاک کردن) (.*)$",
"^[!/#]([Ss]etflood) (%d+)$",
"^([Ss]etflood) (%d+)$",
"^(تنظیم فلود) (%d+)$",
"^[!/#]([Rr]es) (.*)$",
"^([Rr]es) (.*)$",
"^(رس) (.*)$",
"^[!/#]([Ww]hois) (%d+)$",
"^([Ww]hois) (%d+)$",
"^(شخص) (%d+)$",
"^[!/#]([Hh]elp)$",
"^([Hh]elp)$",
"^(راهنما)$",
"^[!/#]([Ss]udohelp)$",
"^([Ss]udohelp)$",
"^(راهنمای سودو)$",
"^[!/#]([Ll]ockhelp)$",
"^([Ll]ockhelp1)$",
"^(راهنماقفل1)$",
"^([Ll]ockhelp2)$",
"^(اهنماقفل2)$",
"^[!/#]([Mm]odhelp)$",
"^([Mm]odhelp)$",
"^(راهنمامدیریت)$",
"^[!/#]([Ff]unhelp)$",
"^([Ff]unhelp)$",
"^(راهنمافان)$",
"^[!/#]([Ss]etlang) (.*)$",
"^([Ss]etlang) (.*)$",
"^(تنظیم زبان) (.*)$",
"^[#!/]([Ff]ilter) (.*)$",
"^([Ff]ilter) (.*)$",
"^(فیلتر) (.*)$",
"^[#!/]([Uu]nfilter) (.*)$",
"^([Uu]nfilter) (.*)$",
"^(حذف فیلتر) (.*)$",
"^[#!/]([Ff]ilterlist)$",
"^([Ff]ilterlist)$",
"^(لیست فیلتر)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#]([Ss]etwelcome) (.*)",
"^([Ss]etwelcome) (.*)",
"^(تنظیم ولکام) (.*)",
"^[!/#]([Ww]elcome) (.*)$",
"^([Ww]elcome) (.*)$",
"^(ولکام) (.*)$"

},
run=run,
pre_process = pre_process
}
--End GroupManager.lua--
