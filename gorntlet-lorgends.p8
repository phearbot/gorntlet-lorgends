pico-8 cartridge // http://www.pico-8.com
version 21
__lua__
-- loop
function _init()
 map_flags()
 init_player()
end

function _update60()
 player_update()
	player_actions()
end

function _draw()
 cls(0)
 draw_map()
 draw_player()
 print(player.moving,0,0,7)
 print(player.deltax,0,8,7)
 print(player.slide,0,16.7)
end

-->8
-- level
function map_flags()
 wall=0
end

function draw_map()
 map(0,0)
end

function tile_attr(tile_type,x,y)
 tile=mget(x,y)
 flags=fget(tile,tile_type)
 return flags
end

function can_move(x,y)
 return not tile_attr(wall,x,y)
end
-->8
-- player
-- ⬆️⬇️⬅️➡️❎ for use in sublime
function init_player()
 player={
  num=1, --player num for color
  x=5*8, -- pos in tiles 
  y=5*8, 
  sprite=34, -- spr id
  spritex=2, -- spr size 
  spritey=3,
  mirror=false,
  direction=down,
  deltax=0, -- movement
  deltay=0,
  maxspeed=2,
  accel=0.5,
  moving=false,
  slide=false,
  friction=.85
 }
end

function draw_player()
 spr(player.sprite,player.x,player.y,player.spritex,player.spritey)
 pal_swap()
end

function player_update()
 --slow that fucker
 player.deltax*=player.friction
 player.deltay*=player.friction

 if btn(⬅️) then
  player.deltax-=player.accel
  player.direction=left
  player.moving=true
 end
 if btn(➡️) then
  player.deltax+=player.accel
  player.direction=right
  player.moving=true
 end
 if btn(⬆️) then
  player.deltay-=player.accel
  player.direction=up
  player.moving=true
 end
 if btn(⬇️) then
  player.deltay+=player.accel
  player.direction=down
  player.moving=true
 end
 

 if player.moving
  and not btn(⬅️)
  and not btn(➡️)
  and not btn(⬆️)
  and not btn(⬇️) then
  player.moving=false
  player.slide=true
 end

 if player.slide then
  if abs(player.deltax)<.2 then
    player.deltax=0
    player.slide=false
  end
 end

  player.x+=player.deltax
  player.y+=player.deltay
end

function player_actions()
 if(btnp(❎)) color_change() 
end

function color_change()
 if(player.num<4)then
  player.num+=1
 else
  player.num=1
 end
end

function pal_swap()
 if (player.num == 1) then
  --as it
  pal(3,3) pal(11,11)
 elseif (player.num == 2) then
  pal(3,1) pal(11,12)
 elseif (player.num == 3) then
  pal(3,4) pal(11,10)
 elseif (player.num == 4) then
  pal(3,2) pal(11,8)
 end
end

__gfx__
000000006d77777777177777d75005000050057d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000761776776dd77666d75005000050057d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000006d577766dd5ddd7dd65600000000656d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dd5766dddd17761d15160001100061510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dd1dd1dd777676d7d75005000050057d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000077676d7766666657d75005000050057d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000076666d77d1666d1dd65600000000656d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d166d1dd7d77777615160001100061510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22222222dd77767665777766ddd1ddd1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21111111d576666ddd7666dd77757775000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21511151d1616dddd1661dd555515551000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21111111766d77777766d77700660066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2111111166dd77766666d77600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
211111116ddd7766666dd76655005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21511151dddddddddddddddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21111111101010101010101000010001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000005555000000000000555500000000000000000000000000005555500000000000000000000000000000000000000000000000000000
00000055550000000000557777550000000055777755000000000055550000000000057777750000000000555550000000000055555000000000000000000000
0000557777550000000549f77f9450000005f777777f50000000557777550000000057fffff95000000005777775000000000577777500000000000000000000
000549f77f94500000059ffffff950000005ff7777ff50000005f777777f500000059ffffff55000000057fffff95000000057f777f950000000000000000000
00059ffffff9500000055ffffff550000005ffffffff50000005ff7777ff50000005fff55557d50000059ffffff5500000059ffffff550000000000000000000
00055ffffff55000005f75555557f5000053ffffffff35000005ffffffff500000059f57777665000005fff55557d5000005fff55557d5000000000000000000
005f75555557f5000056f777777f65000059ffffffff95000053ffffffff3500000549566666d10000059f577776650000059f57777665000000000000000000
0056f777777f65000001d6f77f6d100000059ffffff950000059ffffffff950000005141d66d1000000549566666d100000549566666d1000000000000000000
0001d6f77f6d1000000311d66d113000000549999994500000059ffffff95000000073141111100000005141d66d100000005141d66d10000000000000000000
000311d66d1130000bb5141111415bb0077355444455377000054999999450000007bb31444130000007b3141111100000003314111110000000000000000000
0035141111415300b5bb31444413bb5bb1bb31555513bb1b0073554444553300000b33531113b000007b3531444130000003bb31444130000000000000000000
03bb31444413b33035537b1111b735533113b311113b3113073b31555513bb3000b35d7b333b500007b5d7b311159f000003b353111330000000000000000000
03337b1111b73110433dbbb33bbbd334433dbb3333bbd3340113b311113b33300044d1bbb3b54000044d1bbb3b59fff0000039f333b500000000000000000000
044dbbb33bbbd440f49355599555394ff49355bbbb55394f0443bb333333144000ff41b3393d9f00fff4443313d00f0000001fff533d00000000000000000000
0ff9555995553ff00ff4434ff4334ff00ff4443333444ff00ffd3333335d1ff0000f9331ff13ff00ff44331135300000000311ffff1440000000000000000000
0ffd434ff43340000ff4144554414ff00ff4444444444ff0000444333344ff90000ff41455440000004433bb154000000003b411153441000000000000000000
00045445544140000004155335514000000335533553300000044444444440000000b445115400000001133bb140000000073445111331000000000000000000
0004111335514000000333155133300000033315513330000003bb13331110000000b44103310000000011111100000000b3333105d110000000000000000000
0001333551bb3000000033100133000000003310013300000003b31553331000000b33100310000000001d1d6d000000001331100056d0000000000000000000
0000555001330000000011100111000000001110011100000000331005550000000111000d6d000000005dd55500000000d11000000500000000000000000000
00000000011100000000d6d00d6d00000000d6d00d6d00000000111000000000000d6d000555000000000550000000000056d000000000000000000000000000
000000000d6d00000000555005550000000055500555000000005550000000000005550000000000000000000000000000055000000000000000000000000000
00000000055500000000000000000000000000000000000000005550000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001010101000000000000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0402010201020102010201020102010201020102010202030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0412111211121112111211121112111211121112111212030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0410101010101010101010101010101010101010101010030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0013131313131313131313131313131313131313131313000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200000801003010030000900001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
