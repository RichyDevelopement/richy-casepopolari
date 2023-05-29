richy = {} 

richy.EntrataCasa = vector3(-271.8916, -958.0682, 31.22311) --  Entrata 

richy.TeleportEntrata = vector3(266.02584, -1007.537, -101.0087) --  Tp entrata 

richy.UscitaCasa = vector3(266.02584, -1007.537, -101.0087) --  Uscita 

richy.TeleportUscita = vector3(-269.0146, -957.0797, 31.22312) -- Teletrasporto uscita 

richy.Guardaroba = vector3(259.61526, -1004.039, -99.00855) --  Camerino 

richy.InventarioPopolare = vector3(265.8941, -999.1276, -99.00867) -- inventario

richy.FrigoPopolare = vector3(265.2144, -997.5984, -99.0086) --  frigo bar

-- Deposito 
richy.Label = 'Deposito case'  -- Label 

richy.Slots = 80 -- Slots 

richy.Peso =  150000 -- Peso 

-- Blip 
richy.Popolare = {

    {
        position = vector3(-267.0273, -960.381, 31.22312),
        blip = {
            active = true,
            sprite = 475,
            color = 38,
            size = 0.7,
            name = "Case Popolari"
        }
    },
}

-- Label 
richy.Traduzione = {

    ["entra"] = "Entra in casa",
    ["esci"] = "Esci dalla casa",
    ["inventario"] = "Apri il deposito",
    ["frigobar"] = "Frigo Bar",
    ["camerino"] = "Apri il camerino"

}
--  Npc 
richy.NomeNpc = "a_m_y_smartcaspat_01"
--  Npc 
richy.PosizioneNpc = vector4(-265.6263, -968.1899, 30.29672, 357.8161)
