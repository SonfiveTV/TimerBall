local timerball = {
    name = "timerball",
    key = "timerball",
    set = "Item",
    config = {extra = {round_on_add = 1, legendary = 15, rare = 7, uncommon = 3, common = 1}},
    loc_vars = function(self, info_queue, center)
      info_queue[#info_queue+1] = {set = 'Other', key = 'timer'}
      -- don't know the localization code for rarities
      -- it should be localize('k_common') or something like that
      local rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
      local rarity = rarities[1]
      local round = G.GAME.round - center.ability.extra.round_on_add
      local color = G.C.BLUE
      if round >= center.ability.extra.legendary then
        round = 999
        rarity = rarities[4]
      elseif round >= center.ability.extra.rare then
        round = center.ability.extra.legendary - round
        rarity = rarities[3]
      elseif round >= center.ability.extra.uncommon then
        round = center.ability.extra.rare - round
        rarity = rarities[2]
      elseif round >= center.ability.extra.common then
        round = center.ability.extra.uncommon - round
        rarity = rarities[1]
      end
      return {vars = {rarity, round, colours = {color}}}
      
    end,
    pos = { x = 0, y = 0 },
    atlas = "timerball",
    cost = 3,
    unlocked = true,
    discovered = true,
    can_use = function(self, card)
      if (G.GAME.round - card.ability.extra.round_on_add) >= 3 and #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
        return true
      else
        return false
      end
    end,
    
    use = function(self, card, area, copier)
      if 3 <= (G.GAME.round - card.ability.extra.round_on_add) and (G.GAME.round - card.ability.extra.round_on_add) < 6 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local _card = create_random_poke_joker("timerball", nil, "common", nil, nil)
          _card:add_to_deck()
          G.jokers:emplace(_card)
          return true end }))
      elseif 6 <= (G.GAME.round - card.ability.extra.round_on_add) and (G.GAME.round - card.ability.extra.round_on_add) < 12 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local _card = create_random_poke_joker("timerball", nil, "uncommon", nil, nil)
          _card:add_to_deck()
          G.jokers:emplace(_card)
          return true end }))
      elseif 12 <= (G.GAME.round - card.ability.extra.round_on_add) and (G.GAME.round - card.ability.extra.round_on_add) < 24 then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local _card = create_random_poke_joker("timerball", nil, "rare", nil, nil)
          _card:add_to_deck()
          G.jokers:emplace(_card)
          return true end }))
      elseif 24 <= (G.GAME.round - card.ability.extra.round_on_add)  then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          play_sound('timpani')
          local _card = create_random_poke_joker("timerball", "Legendary")
          _card:add_to_deck()
          G.jokers:emplace(_card)
          return true end }))
      end
    delay(0.6)
    end,
    set_ability = function(self, card, initial, delay_sprites)
      if initial then
        card.ability.extra.round_on_add = G.GAME.round
      end
    end,

  }
  local list = {timerball}

  

return {name = "Items",
    list = list


}
  
