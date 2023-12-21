--setVehicleHandling ( element theVehicle, string property, var value )

-- Anthony Script -- 2015.09.21. 22:51
-- Felhasznált weboldal: http://gta.wikia.com/wiki/Handling.cfg/GTASA --


--setVehicleHandling(veh, "mass", 2600)
--setVehicleHandling(veh, "turnMass", 6333.3)
--setVehicleHandling(veh, "dragCoeff",2.0)
--setVehicleHandling(veh, "centerOfMass", { 0.0, 0.0, -0.2})
--setVehicleHandling(veh, "percentSubmerged", 80)
--setVehicleHandling(veh, "tractionMultiplier", 0.95)
--setVehicleHandling(veh, "tractionLoss", 0.70)
--setVehicleHandling(veh, "tractionBias", 0.46)  Autó csúszkálása 
--setVehicleHandling(veh, "numberOfGears", 5)
--setVehicleHandling(veh, "maxVelocity", 860)  -- végsebesség 
--setVehicleHandling(veh, "engineAcceleration", 15)   -- Gyorsulás 
--setVehicleHandling(veh, "engineInertia", 30)
--setVehicleHandling(veh, "driveType", "FWD")
--setVehicleHandling(veh, "engineType", "petrol")
--setVehicleHandling(veh, "brakeDeceleration", 3.0)   -- fékezés 
--setVehicleHandling(veh, "brakeBias", 0.80)
--setVehicleHandling(veh, "ABS", false)
--setVehicleHandling(veh, "steeringLock", 44.0) Fordulási szög
--setVehicleHandling(veh, "suspensionForceLevel", 1.5)
--setVehicleHandling(veh, "suspensionDamping", 0.07)
--setVehicleHandling(veh, "suspensionHighSpeedDamping", 2.0)
--setVehicleHandling(veh, "suspensionUpperLimit", 0.20)
--setVehicleHandling(veh, "suspensionLowerLimit", -0.12)
--setVehicleHandling(veh, "suspensionFrontRearBias", 0.45)
--setVehicleHandling(veh, "suspensionAntiDiveMultiplier", 0.0)
--setVehicleHandling(veh, "seatOffsetDistance", 0.2) 
--setVehicleHandling(veh, "collisionDamageMultiplier", 0.43)
--setVehicleHandling(veh, "monetary", 20000)
--setVehicleHandling(veh, "modelFlags", 1)
--setVehicleHandling(veh, "handlingFlags", 1)
--setVehicleHandling(veh, "headLight", 0)
--setVehicleHandling(veh, "tailLight", 3)
--setVehicleHandling(veh, "animGroup", 13)



--suspensionHighSpeedDamping Padka megdobás
--alapcuccos
			-- [[setVehicleHandling(v, "maxVelocity", 320)
				--setVehicleHandling(v, "engineAcceleration", 19)
				--setVehicleHandling(v, "engineInertia", 50.0)
				--setVehicleHandling(v, "engineType", "petrol")
				--setVehicleHandling(v, "dragCoeff",2.0)
				--setVehicleHandling(v, "brakeDeceleration", 1)
				--setVehicleHandling(v, "ABS", false)
				--setVehicleHandling(v, "steeringLock", 45.0)
				--setVehicleHandling(v, "driveType", "awd")
				--setVehicleHandling(v, "tractionMultiplier", 1)
                --setVehicleHandling(v, "tractionLoss", 1)
                --setVehicleHandling(v, "tractionBias", 0.5)
				--setVehicleHandling(v, "suspensionDamping", 0.75)
				--setVehicleHandling(v, "suspensionUpperLimit", 0.42) --lengéscsillapító, minél magasabb anál lágyabb
				--setVehicleHandling(v, "suspensionLowerLimit", 1)
				--setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
				--setVehicleHandling(v, "suspensionForceLevel", 1.3 )--kerék-karosszéria táv növelés  plusz pattogá
				--setVehicleHandling(v, "brakeBias", 0.5)
		
--addEvent("UpdateHandling",true);

		function loadHandling(v)	
	--[[	if getElementModel(v) == 480 then 			-- comet 2ajós üres cabiro
			setVehicleHandling(v, "maxVelocity", 320 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 35 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 60)
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 15 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.55) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
		end --]]
		
		--[[if getElementModel(v) == 424 then 			--ÜRES 	BF injection valami buggy szerü OFF 
				setVehicleHandling(v, "maxVelocity", 500)
				setVehicleHandling(v, "engineAcceleration", 60.5)
				setVehicleHandling(v, "engineInertia", 100)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 390.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.51)
                setVehicleHandling(v, "tractionLoss", 0.93)
                setVehicleHandling(v, "tractionBias", 0.36)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.3, -0.3})
				setVehicleHandling(v, "suspensionDamping", 0.2)
				setVehicleHandling(v, "suspensionForceLevel", 0.75)
				setVehicleHandling(v, "mass", 1550)
		end	--]]
		--[[if getElementModel(v) == 434 then   ------- Hotknife 2ajtó ÜRES
				setVehicleHandling(v, "maxVelocity", 270)
				setVehicleHandling(v, "engineAcceleration", 44.5)
				setVehicleHandling(v, "engineInertia", 46.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 390.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.81)
                setVehicleHandling(v, "tractionLoss", 0.93)
                setVehicleHandling(v, "tractionBias", 0.36)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.3, -0.3})
				setVehicleHandling(v, "suspensionDamping", 0.2)
				setVehicleHandling(v, "suspensionForceLevel", 1.05)
				setVehicleHandling(v, "mass", 1550)
		end		---]]
		if getElementModel(v) == 494 then 	-- LaFerrari
			setVehicleHandling(v, "maxVelocity", 350 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 41 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 55)
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 15 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.55} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
		end

			--Perennial                          --- 
		--[[if getElementModel(v) == 418 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.95 )--kerék-karosszéria táv növelés  plusz pattogá
		end  --]]

		
			-- Landstalker - BMW X5
		if getElementModel(v) == 400 then  ------- 
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "maxVelocity", 220 ) --- végsebesség most 500
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2	
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.75} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionUpperLimit", 0.1) --lengéscsillapító, minél magasabb anál lágyabb
				setVehicleHandling(v, "brakeDeceleration", 90) 
				setVehicleHandling(v, "suspensionFrontRearBias", 0.42) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.7 )--kerék-karosszéria táv növelés  plusz pattogá
		end	

		--[[if getElementModel(v) == 543 then      ----- Sadler Ford Raptor
				setVehicleHandling(v, "maxVelocity", 220 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 14 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		 			
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.55) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.7 )--kerék-karosszéria táv növelés  plusz pattogá
		end	--]]
		
		if getElementModel(v) == 502 then        ------ Mercedes-Benz C63 AMG
				setVehicleHandling(v, "maxVelocity", 230 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.47) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
		end	
		
		if getElementModel(v) == 503 then     ---Bugatti Chiron
				setVehicleHandling(v, "maxVelocity", 320 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 35 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 40 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1.2 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "tractionBias", 0.45 ) 	
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.4} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.65 )--kerék-karosszéria táv növelés  plusz pattogá
		 end		
			  -- Rancher      --------- Mercedes-Benz G65 bugos CSERE
		 if getElementModel(v) == 489 then
				setVehicleHandling(v, "maxVelocity", 222)
				setVehicleHandling(v, "engineAcceleration", 22.0)
				setVehicleHandling(v, "engineInertia", 50.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "dragCoeff",2.0)
				setVehicleHandling(v, "brakeDeceleration", 500.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.0)
                setVehicleHandling(v, "tractionLoss", 0.8)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "suspensionDamping", 0.75)
				setVehicleHandling(v, "suspensionForceLevel", 3)
				setVehicleHandling(v, "suspensionUpperLimit", 0.45) --lengéscsillapító, minél magasabb anál lágyabb
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
		 end
		
			  -- Mesa      -------Jeep  ÜRES 2ajtós
		 --[[if getElementModel(v) == 500 then
				setVehicleHandling(v, "maxVelocity", 139)
				setVehicleHandling(v, "engineAcceleration", 24.5)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
		end	--]]
			  --               -------- BRABUS 700 G LEVENTE LEVI UBUL EGYEDI AUTÓ Mercedes-Benz
		 if getElementModel(v) == 470 then
				setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 20 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.4 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 10 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.6} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionUpperLimit", 0.25) --lengéscsillapító, minél magasabb anál lágyabb
		setVehicleHandling(v, "suspensionLowerLimit", -0.25)
		setVehicleHandling(v, "suspensionFrontRearBias", 0.6) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
		end	
		
			  -- Rancher      Kula katonai szar
		 if getElementModel(v) == 505 then        
				setVehicleHandling(v, "maxVelocity", 162)
				setVehicleHandling(v, "engineAcceleration", 25.0)
				setVehicleHandling(v, "engineInertia", 50.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "dragCoeff",2.0)
				setVehicleHandling(v, "brakeDeceleration", 500.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.1)
                setVehicleHandling(v, "tractionLoss", 0.8)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "suspensionDamping", 0.75)
				setVehicleHandling(v, "suspensionForceLevel", 3)
				setVehicleHandling(v, "suspensionUpperLimit", 0.45) --lengéscsillapító, minél magasabb anál lágyabb
				setVehicleHandling(v, "suspensionLowerLimit", -0.10)
		end		
		
			  -- FreeWay - x
		if getElementModel(v) == 463 then
				setVehicleHandling(v, "maxVelocity", 215)
				setVehicleHandling(v, "engineAcceleration", 20.0)

		end	
		
			  -- NRG-500 - x
		if getElementModel(v) == 522 then
				setVehicleHandling(v, "maxVelocity", 337)
				setVehicleHandling(v, "engineAcceleration", 25.0)
		end		
			  -- PCJ-600 - x
		if getElementModel(v) == 461 then
				setVehicleHandling(v, "maxVelocity", 240)
				setVehicleHandling(v, "engineAcceleration", 20.0)
		end		
			  -- BF-400 - x
		if getElementModel(v) == 581 then
			    setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 20.0)				
				
		end	
		
			-- Ambulan
			if getElementModel(v) == 416 then
				setVehicleHandling(v, "mass", 2600)
				setVehicleHandling(v, "turnMass", 7000)
				setVehicleHandling(v, "dragCoeff", 1.7)
				setVehicleHandling(v, "centerOfMass", { 0, 0, -0.1 } )
				setVehicleHandling(v, "percentSubmerged", 90)
				setVehicleHandling(v, "tractionMultiplier", 0.85)
				setVehicleHandling(v, "tractionLoss", 0.8)
				setVehicleHandling(v, "tractionBias", 0.47)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 184)
				setVehicleHandling(v, "engineAcceleration", 24)
				setVehicleHandling(v, "engineInertia", 40)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "diesel")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.07)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0)
				setVehicleHandling(v, "suspensionUpperLimit", 0.4)
				setVehicleHandling(v, "suspensionLowerLimit", -0.25)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0)
				setVehicleHandling(v, "seatOffsetDistance", 0.58)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.33)
				setVehicleHandling(v, "modelFlags", 0x4001)
				setVehicleHandling(v, "handlingFlags", 0x10100006)
		    end	
			-- PD motor
			if getElementModel(v) == 523 then
				setVehicleHandling(v, "maxVelocity", 230)
				setVehicleHandling(v, "engineAcceleration", 19.0)
				setVehicleHandling(v, "engineInertia", 5.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.8)
                setVehicleHandling(v, "tractionLoss", 1.15)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 19.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.09})
				setVehicleHandling(v, "dragCoeff",0.0)
			 end	
				
			 -- Glendale - x      ---------- Mercedes-Benz C63 (régebbi)
			if getElementModel(v) == 466 then
				setVehicleHandling(v, "maxVelocity", 230 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 20 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.47) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			 end 	
			 				
			 -- asd- x
			 if getElementModel(v) == 456 then
				setVehicleHandling(v, "suspensionForceLevel", 0.5)
			 end

			 -- Hermes - x    Hemi Cuda
			 if getElementModel(v) == 474 then
				setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.6} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.53) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
			 end	
			 
			 -- Esperanto - x 		M8 Vito
			  if getElementModel(v) == 419 then
				setVehicleHandling(v, "maxVelocity", 380 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 25 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "steeringLock", 25 ) --- fordulási szög			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.55} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
			 end 	
			 
			 -- Buccaneer - x    ------  Nissan Silvia s15
			 if getElementModel(v) == 518 then
				setVehicleHandling(v, "maxVelocity", 210)
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "engineInertia", 51.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
			end 
				--------- 
			 if getElementModel(v) == 404 then -- Lamborghini Urus
				 setVehicleHandling(v, "maxVelocity", 240 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 0.9 ) --- fékezés most 2		
				setVehicleHandling(v, "brakeDeceleration", 20 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.55} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.7 )--kerék-karosszéria táv
			 end
			 
			 --  - x           ----- BMW M3 
		--[[	 if getElementModel(v) == 526 then
				setVehicleHandling(v, "mass", 1600)
				setVehicleHandling(v, "turnMass", 3000)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 0.0, -0.5 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 0.7)
				setVehicleHandling(v, "tractionLoss", 0.7)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 210)
				setVehicleHandling(v, "engineAcceleration", 16)
				setVehicleHandling(v, "engineInertia", 40)
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
				setVehicleHandling(v, "suspensionUpperLimit", 0.20)
				setVehicleHandling(v, "suspensionLowerLimit", -0.08)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.3) --Dőlésszög az eleje és hátulja között
			 end	--]]
			 
			 -- Stratum - x             ---BMW M5 E39
			 if getElementModel(v) == 561 then
				 setVehicleHandling(v, "maxVelocity", 240 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 20 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 40 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "brakeBias", 23 ) --- fékezés most 2		
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "brakeDeceleration", 50.0)
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.5} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end 
			 
			 -- Tornado - x    --- Chevrolet Camaro 
			 if getElementModel(v) == 576 then
				setVehicleHandling(v, "maxVelocity", 240 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 22 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 22 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 19 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.75} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.44) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 -- Majestic ---------- Chevrolet SS 
			 if getElementModel(v) == 517 then
				setVehicleHandling(v, "maxVelocity", 175)
				setVehicleHandling(v, "engineAcceleration", 15.0)
				setVehicleHandling(v, "engineInertia", 45.0)
				setVehicleHandling(v, "tractionMultiplier", 0.8)
                setVehicleHandling(v, "tractionLoss", 0.8)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 50.0)
			end 
			 
			 -- Voodoo - x     ----- SEMMI ÜRES 2Ajtós
			 --[[if getElementModel(v) == 412 then
				setVehicleHandling(v, "maxVelocity", 130)
				setVehicleHandling(v, "engineAcceleration", 16.0)
				setVehicleHandling(v, "engineInertia", 45.0)
			 end--]]
			 
			 -- Remington - x    ------ Lincolt Town Cupé
			 if getElementModel(v) == 534 then
				setVehicleHandling(v, "maxVelocity", 160)
				setVehicleHandling(v, "engineAcceleration", 13.0)
				setVehicleHandling(v, "engineInertia", 50.0)
				setVehicleHandling(v, "tractionMultiplier", 0.75)
                setVehicleHandling(v, "tractionLoss", 0.84)
                setVehicleHandling(v, "tractionBias", 0.55)
			 end
			 -- Blade - x  ------- Üres 2ajtós cabrio
			--[[ if getElementModel(v) == 536 then
				setVehicleHandling(v, "maxVelocity", 180)
				setVehicleHandling(v, "engineAcceleration", 15.0)
				setVehicleHandling(v, "engineInertia", 45.0)
				setVehicleHandling(v, "tractionMultiplier", 0.75)
                setVehicleHandling(v, "tractionLoss", 0.85)
                setVehicleHandling(v, "tractionBias", 0.52)
			 end	--]]
			 -- Savanna - x    ------ Chevi Impala
			 if getElementModel(v) == 567 then
				setVehicleHandling(v, "maxVelocity", 190)
				setVehicleHandling(v, "engineAcceleration", 16.0)
				setVehicleHandling(v, "engineInertia", 47.0)
				setVehicleHandling(v, "tractionMultiplier", 0.76)
                setVehicleHandling(v, "tractionLoss", 0.86)
                setVehicleHandling(v, "tractionBias", 0.6)
			 end	
			 -- Stallion - x  ------ Dodge Charger R/T
			 if getElementModel(v) == 439 then
			setVehicleHandling(v, "maxVelocity", 200)
			setVehicleHandling(v, "engineAcceleration", 20)
			setVehicleHandling(v, "engineInertia", 50.0)
			setVehicleHandling(v, "engineType", "petrol")
			setVehicleHandling(v, "brakeDeceleration", 420.0)
			setVehicleHandling(v, "ABS", true)
			setVehicleHandling(v, "driveType", "awd")
			setVehicleHandling(v, "steeringLock", 35.0)
			setVehicleHandling(v, "tractionMultiplier", 1.05)
			setVehicleHandling(v, "tractionLoss", 0.85)
			setVehicleHandling(v, "tractionBias", 0.49)
			setVehicleHandling(v, "suspensionForceLevel", 0.60)
			setVehicleHandling(v, "centerOfMass", { 0.0, -0.15, -0.65})
			setVehicleHandling(v, "dragCoeff",1.0)
			setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
			 end	
			 
			 -- Manana - x   ----------- Mercedes-Benz SLR McLaren 722
			if getElementModel(v) == 410 then
			setVehicleHandling(v, "maxVelocity", 350 ) --- végsebesség most 500
			setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
			setVehicleHandling(v, "engineInertia", 59 ) --- gyorsulás most 30
			setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
			setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
			setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
			setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
			setVehicleHandling(v, "suspensionFrontRearBias", 0.43) --Dőlésszög az eleje és hátulja között
			setVehicleHandling(v, "suspensionForceLevel", 0.95 )--kerék-karosszéria táv növelés  plusz pattogá
	
			 end 
			 
			  if getElementModel(v) == 409 then -- limuzin
				setVehicleHandling(v, "maxVelocity", 180)
				setVehicleHandling(v, "engineAcceleration", 15.0)
				setVehicleHandling(v, "engineInertia", 50.0)
				setVehicleHandling(v, "tractionMultiplier", 0.74)
                setVehicleHandling(v, "tractionLoss", 0.8)
                setVehicleHandling(v, "tractionBias", 0.51)
                setVehicleHandling(v, "suspensionUpperLimit", 0.40)
                setVehicleHandling(v, "suspensionLowerLimit", -0.25)
			 end	
			 
			 -- Banshee - x   Fenyr
			 if getElementModel(v) == 429 then
				setVehicleHandling(v, "maxVelocity", 410 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.5} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.55) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
			 end	
			 -- Tampa - x       ------- Audi R8
			 if getElementModel(v) == 549 then 
				setVehicleHandling(v, "maxVelocity", 396 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.55) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
			 end 
			 
			 -- Jester - x     -- Toyota Supra 
			 if getElementModel(v) == 559 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "engineInertia", 51.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
			end 
			 -- Premier - x     --------- ÜRES 4ajtós
			--[[ if getElementModel(v) == 426 then
				setVehicleHandling(v, "maxVelocity", 230 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.43) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	--]]
			 
			 -- taxi
			 if getElementModel(v) == 420 then
				setVehicleHandling(v, "maxVelocity", 130)
				setVehicleHandling(v, "engineAcceleration", 13.0)
				setVehicleHandling(v, "engineInertia", 40.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.1})
			 end
			 
			 -- taxi 2
			 if getElementModel(v) == 438 then
				setVehicleHandling(v, "maxVelocity", 130)
				setVehicleHandling(v, "engineAcceleration", 16.0)
				setVehicleHandling(v, "engineInertia", 40.0)
				setVehicleHandling(v, "suspensionForceLevel", 0.6)
				setVehicleHandling(v, "driveType", "awd")
			 end
			 
			 -- Clover - x   ------------- 
			--[[ if getElementModel(v) == 542 then
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 23 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 18 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 19 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
			 end	--]]
			 -- Slamvan - x   ------------ Toyota GT86 Rocket Bunny
			 if getElementModel(v) == 535 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 23)
				setVehicleHandling(v, "engineInertia", 21.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.35) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 1.2 )--kerék-karosszéria táv növelés  plusz patt
			 end
			 
			 -- Pony - x 		Ford Econoline 150
			 if getElementModel(v) == 413 then
				setVehicleHandling(v, "maxVelocity", 145)
				setVehicleHandling(v, "engineAcceleration", 14.0)
				setVehicleHandling(v, "engineInertia", 44.0)
				setVehicleHandling(v, "engineType", "diesel")
				setVehicleHandling(v, "brakeDeceleration", 6.0)
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 0.62)
                setVehicleHandling(v, "tractionLoss", 0.9)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "dragCoeff",2.0)
				setVehicleHandling(v, "suspensionForceLevel", 1.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.4, -0.30})
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 2.0)
                setVehicleHandling(v, "suspensionUpperLimit", 0.3)
                setVehicleHandling(v, "suspensionLowerLimit", -0.1)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.3)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5)
				setVehicleHandling(v, "mass", 2000)
                setVehicleHandling(v, "turnMass", 4500.0)
			 end	
			 
			 -- Police Ranger --> x      ------ SEMMI Üres CSERE 2Ajtós terepjaro
			--[[ if getElementModel(v) == 599 then
				setVehicleHandling(v, "maxVelocity", 200)
				setVehicleHandling(v, "engineAcceleration", 50.0)
				setVehicleHandling(v, "engineInertia", 75.0)
				setVehicleHandling(v, "suspensionDamping", 50.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 500.0)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.0)
                setVehicleHandling(v, "tractionLoss", 0.85)
                setVehicleHandling(v, "tractionBias", 0.47)
				setVehicleHandling(v, "centerOfMass", { 0, 0.15, -0.3 } )
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
			end	--]]
			
             -- FBI Rancher - x    ------ Cadillac Escalade Eskalács Rendőrségi
			 if getElementModel(v) == 490 then 
		setVehicleHandling(v, "maxVelocity", 220 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 14 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.2 ) --- fékezés most 2				
		setVehicleHandling(v, "centerOfMass", {0.0, 0.1, -0.5} )		
		setVehicleHandling(v, "driveType", "fwd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv növelés  plusz patt
			 end	
			 
		if getElementModel(v) == 596 then -- Rendőrségi Skoda           
				setVehicleHandling(v, "maxVelocity", 230 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.43) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
	end	
			
			 if getElementModel(v) == 597 then -- Mercedes-Benz GLE 63 Rendőrségi
				setVehicleHandling(v, "maxVelocity", 180 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 15 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.65} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.7 )--kerék-karosszéria táv növelés  plusz pattogá
	end
		
		if getElementModel(v) == 598 then-- Audi RS6 Rendőrségi
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 16 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 17 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.65} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv növelés  plusz pattogá
	end
		
	--[[	if getElementModel(v) == 427 then -- rendőrségi enforcer
		setVehicleHandling(v, "maxVelocity", 300 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 10 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.6 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.3 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.1, -0.4} )
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv növelés  plusz pattogás

	end	--]]

			 -- Nebula - x     BMW 540i G30
			 if getElementModel(v) == 516 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 18 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 40 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.86 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 20 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.5} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.52) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 2 )--kerék-karosszéria táv növelés  plusz pattogá
			end
			
			 -- BMW M4 - x 
			if getElementModel(v) == 401 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 18 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 40 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.86 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.65} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.52) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.5 )--kerék-karosszéria táv növelés  plusz pattogá
				 
			end
			 -- Koenigsegg Jesko uranus Uranus
			if getElementModel(v) == 558 then
		setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 40 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "brakeDeceleration", 20 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.43) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1 )--kerék-karosszéria táv növelés  plusz pattogá
				 
			end	
		 	 -- Flash - x      2ajtós üres
			 --[[-- Flash - x      ---------- Subaru BRZ Volt már üres 
			 if getElementModel(v) == 565 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "engineInertia", 51.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
		    end --]]
			 -- Fortune - x      ---- BMW M3 Gpower
			 if getElementModel(v) == 526 then
				setVehicleHandling(v, "maxVelocity", 210 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 15 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 30 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 0.8 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "brakeBias", 23 ) --- fékezés most 2		
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "brakeDeceleration", 50.0)
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.5} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.42) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv
		
			end	
			
              -- Intruder - x      --------- Lada
			 if getElementModel(v) == 546 then
				setVehicleHandling(v, "maxVelocity", 160 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 12 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "brakeDeceleration", 15 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.9 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.65) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1 )--kerék-karosszéria táv
			 end	
			 
			 if getElementModel(v) == 578 then
				setVehicleHandling(v, "maxVelocity", 140)
				setVehicleHandling(v, "brakeDeceleration", 12)
				setVehicleHandling(v, "driveType", "awd")
			end 
			 -- Bullet - x        ------   Mercedes-Benz S63 amg
			 if getElementModel(v) == 541 then
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 22 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 25 ) --- gyorsulás most 30
				setVehicleHandling(v, "brakeDeceleration", 19 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.44) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 1.1 )--kerék-karosszéria táv növelés  plusz pattogá
			 end 
			 
			 -- Tahoma - x     ----- Mercedes Benz C250
			 if getElementModel(v) == 566 then
				setVehicleHandling(v, "maxVelocity", 210 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 25 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
			 end	
			 
			 -- Elegy - x   ----- Aston Martin Vantage
			 if getElementModel(v) == 562 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 27)
				setVehicleHandling(v, "engineInertia", 50.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1.2)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
			 end	
			 
			 -- Blista Compact - x       ------- Scirocco vagy mi a rák
			 if getElementModel(v) == 496 then
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 16 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 1.05 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 
			 -- Willard - x         --------- Mercedes-Benz S500 Csuhy
			 if getElementModel(v) == 529 then
				setVehicleHandling(v, "maxVelocity", 280 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 20 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 87 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "brakeDeceleration", 390.0)
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end 	
			 
			 -- Club - x ------ Rolls Royce Wrait
			 if getElementModel(v) == 589 then
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 25 ) --- gyorsulás most 30
				setVehicleHandling(v, "engineInertia", 30 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 0.95 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.55} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 
			 -- Primo - x    ------ Ford Focus RS 
			 if getElementModel(v) == 547 then
				setVehicleHandling(v, "maxVelocity", 240 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 42)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.48) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end	 
			 
			 -- Yosemite - x        ------- Ford Raptor
			 if getElementModel(v) == 554 then
				setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 17 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 10 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.48} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.87 )--kerék-karosszéria táv növelés  plusz pattogá
			 end 
			 
			 -- Sultan - x EVO X 
			 if getElementModel(v) == 560 then
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "engineInertia", 51.0)
				setVehicleHandling(v, "engineType", "petrol")
			    setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.65)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "suspensionDamping", 0.7)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.25})
				setVehicleHandling(v, "dragCoeff",1.0)
				setVehicleHandling(v, "mass", 1500)
                setVehicleHandling(v, "turnMass", 2000.0)
				setVehicleHandling(v, "modelFlags", 0x800)
				setVehicleHandling(v, "handlingFlags", 0x4004402)
			 end	
			 
			 -- Huntley - x            Mercedes-Benz G63 AMG
			 if getElementModel(v) == 579 then
				setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 10 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.42) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 -- Broadway - x --------- SEMMI ÜRES CSERE lowrider 2ajtós
			--[[ if getElementModel(v) == 575 then
				setVehicleHandling(v, "maxVelocity", 114)
				setVehicleHandling(v, "suspensionUpperLimit", 0.15)
				setVehicleHandling(v, "suspensionLowerLimit", -0.1)

			 end --]]
			 
			 -- Cadrona - x  ------- Ford Mustang
			 if getElementModel(v) == 527 then
				setVehicleHandling(v, "maxVelocity", 290 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 28 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 68 ) --- gyorsulás most 30
		setVehicleHandling(v, "brakeDeceleration", 55 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1.1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.65} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 -- BMW E30
		--[[	 if getElementModel(v) == 600 then
				setVehicleHandling(v, "maxVelocity", 210 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 16 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.42) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1.5 )--kerék-karosszéria táv
			 end --]]
			 
			 -- Admiral - x   BMW M5
			 if getElementModel(v) == 445 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 29 ) --- gyorsulás most 30
		setVehicleHandling(v, "brakeDeceleration", 12 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.87 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.85 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1.2 )--kerék-karosszéria táv
			 end	
			 -- Stafford - x Audi RS4
			 if getElementModel(v) == 580 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 19 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.9 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
			  end	
			  -- Emperor - x  Audi 80 vagy mi a rák
			  if getElementModel(v) == 585 then
				setVehicleHandling(v, "maxVelocity", 150 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 13 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.9 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
			 end	
			 -- Solair - x GLE gle
			 if getElementModel(v) == 458 then
				setVehicleHandling(v, "maxVelocity", 302)
				setVehicleHandling(v, "engineAcceleration", 25)
				setVehicleHandling(v, "engineInertia", 87.0)
				setVehicleHandling(v, "turnMass", 2500.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.70)
                setVehicleHandling(v, "tractionBias", 0.55)
                setVehicleHandling(v, "brakeBias", 0.4)
				setVehicleHandling(v, "suspensionDamping", 0.9)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.5})
				setVehicleHandling(v, "mass", 1600.0)
				setVehicleHandling(v, "dragCoeff", 1.7)
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "suspensionForceLevel", 1.2)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.0)
				setVehicleHandling(v, "suspensionUpperLimit", 0.32)
				setVehicleHandling(v, "suspensionLowerLimit", -0.12)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.45)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.3)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.56)
				setVehicleHandling(v, "modelFlags", 0x0)
				setVehicleHandling(v, "handlingFlags", 0x400000)
			 end

			 -- Hotknife - 
			--[[ if getElementModel(v) == 434 then
			setVehicleHandling(v, "maxVelocity", 350)
			setVehicleHandling(v, "engineAcceleration", 70)
			setVehicleHandling(v, "engineInertia", 60.0)
			setVehicleHandling(v, "engineType", "petrol")
			setVehicleHandling(v, "brakeDeceleration", 500.0)
			setVehicleHandling(v, "ABS", true)
			setVehicleHandling(v, "driveType", "awd")
			setVehicleHandling(v, "steeringLock", 35.0)
			setVehicleHandling(v, "tractionMultiplier", 1.13)
			setVehicleHandling(v, "tractionLoss", 0.95)
			setVehicleHandling(v, "tractionBias", 0.50)
			setVehicleHandling(v, "suspensionForceLevel", 1.1)
			setVehicleHandling(v, "centerOfMass", { 0.0, -0.05, -0.3})
			setVehicleHandling(v, "dragCoeff",1.0)
			setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
			setVehicleHandling(v, "suspensionLowerLimit", -0.10)
			 end	--]]

			-- alpha -    GT3 RS Porsche
			if getElementModel(v) == 602 then
				setVehicleHandling(v, "maxVelocity", 260 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 52)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.48) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end
			 
			 --    ÜRES --previon 2ajtó
		--[[	 if getElementModel(v) == 436 then
				setVehicleHandling(v, "maxVelocity", 190 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 16 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "fwd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.51) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1 )--kerék-karosszéria táv)
			 end	--]]
			 -- Sunrise - x         Mercedes-Benz E320
			 if getElementModel(v) == 550 then
				setVehicleHandling(v, "maxVelocity", 190 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 15 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.48) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1.05 )--kerék-karosszéria táv
			 end	
			 -- Sentinel - x      Audi A8
			 if getElementModel(v) == 405 then
				setVehicleHandling(v, "maxVelocity", 215 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 18 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.95 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.47) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.9 )--kerék-karosszéria táv
			 end	
			 -- Phoenix - x         Dodge Challenger SRT Hellcat
			 if getElementModel(v) == 475 then
				setVehicleHandling(v, "maxVelocity", 215 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 17 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.95 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.47) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1.1 )--kerék-karosszéria táv
			 end	
			 -- Merit - x      BMW 750
			 if getElementModel(v) == 551 then
				setVehicleHandling(v, "maxVelocity", 220)
				setVehicleHandling(v, "engineAcceleration", 17.0)
				setVehicleHandling(v, "engineInertia", 53.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 6.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.3)
                setVehicleHandling(v, "tractionLoss", 0.67)
                setVehicleHandling(v, "tractionBias", 0.48)
				setVehicleHandling(v, "suspensionForceLevel", 0.45)
				setVehicleHandling(v, "suspensionUpperLimit", 0.05)
				setVehicleHandling(v, "suspensionLowerLimit", -0.15)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.2, -0.08})
			 end	
			 -- Washington - x        BMW 750li vagymi a 
			 if getElementModel(v) == 421 then
				setVehicleHandling(v, "maxVelocity", 230 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 18 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.9 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.9 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "rwd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end	
			 -- Euros - x Nissan GTR
			 if getElementModel(v) == 587 then
				setVehicleHandling(v, "maxVelocity", 270 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 25 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
		setVehicleHandling(v, "brakeDeceleration", 21 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 1.2 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
             -- Turismo - x Aston Martin Vulcan
			 if getElementModel(v) == 451 then
				setVehicleHandling(v, "maxVelocity", 350 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 32 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 55 ) --- gyorsulás most 30
		setVehicleHandling(v, "brakeDeceleration", 12 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end
			
             -- Virgo - -- Audi RS5
			 if getElementModel(v) == 491 then
				setVehicleHandling(v, "maxVelocity", 390 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 25 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 43)
		setVehicleHandling(v, "tractionMultiplier", 1.2 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.8 )--kerék-karosszéria táv
			 end
			 
			 -- Infernus - x Ferrari 488
			 if getElementModel(v) == 411 then
				setVehicleHandling(v, "maxVelocity", 360 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 31 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 60 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.5) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv
			 end	
             -- Buffalo - x         Pontiac Firebird
			 if getElementModel(v) == 402 then
				setVehicleHandling(v, "maxVelocity", 210)
				setVehicleHandling(v, "engineAcceleration", 19)
				setVehicleHandling(v, "engineInertia", 47.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 100.0)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.03)
                setVehicleHandling(v, "tractionLoss", 0.75)
                setVehicleHandling(v, "tractionBias", 0.49)
				setVehicleHandling(v, "suspensionForceLevel", 1)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.1, -0.15})
				setVehicleHandling(v, "suspensionDamping", 0.3)
			 end	
             -- cheetah - x       Bugatti Veyron
			 if getElementModel(v) == 415 then
				setVehicleHandling(v, "maxVelocity", 432)
				setVehicleHandling(v, "engineAcceleration", 40)
				setVehicleHandling(v, "engineInertia", 65.0)
				setVehicleHandling(v, "turnMass", 2500.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 420.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.15)
                setVehicleHandling(v, "tractionLoss", 0.70)
                setVehicleHandling(v, "tractionBias", 0.55)
                setVehicleHandling(v, "brakeBias", 0.4)
				setVehicleHandling(v, "suspensionDamping", 0.9)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.5})
				setVehicleHandling(v, "mass", 1600.0)
				setVehicleHandling(v, "dragCoeff", 1.7)
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "suspensionForceLevel", 0.9)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.0)
				setVehicleHandling(v, "suspensionUpperLimit", 0.32)
				setVehicleHandling(v, "suspensionLowerLimit", -0.12)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.5)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.3)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.56)
				setVehicleHandling(v, "modelFlags", 0x0)
				setVehicleHandling(v, "handlingFlags", 0x400000)
			 end	
			 -- Sabre - x        Mercedes-Benz AMG GT
			 if getElementModel(v) == 603 then
				setVehicleHandling(v, "maxVelocity", 390 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 45)
		setVehicleHandling(v, "tractionMultiplier", 1.4 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2			
		setVehicleHandling(v, "brakeDeceleration", 25 ) --- fékezés most 2		
		setVehicleHandling(v, "tractionBias", 0.35 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.5} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.7 )--kerék-karosszéria táv
			 end	
			 -- Windsor - x 		Bentley Continental
			 if getElementModel(v) == 555 then
				setVehicleHandling(v, "maxVelocity", 250 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 31 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 55 ) --- gyorsulás most 30
		setVehicleHandling(v, "brakeDeceleration", 12 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.52) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end	
			 -- Super GT - x		McLaren P1
			 if getElementModel(v) == 506 then
			setVehicleHandling(v, "maxVelocity", 380)
			setVehicleHandling(v, "engineAcceleration", 35)
			setVehicleHandling(v, "engineInertia", 55.0)
			setVehicleHandling(v, "engineType", "petrol")
			setVehicleHandling(v, "brakeDeceleration", 420.0)
			setVehicleHandling(v, "ABS", true)
			setVehicleHandling(v, "driveType", "awd")
			setVehicleHandling(v, "steeringLock", 35.0)
			setVehicleHandling(v, "tractionMultiplier", 1.3)
			setVehicleHandling(v, "tractionLoss", 0.85)
			setVehicleHandling(v, "tractionBias", 0.49)
			setVehicleHandling(v, "suspensionForceLevel", 1.2)
			setVehicleHandling(v, "centerOfMass", { 0.0, -0.15, -0.3})
			setVehicleHandling(v, "dragCoeff",1.0)
			setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
			setVehicleHandling(v, "suspensionLowerLimit", -0.10)
			 end
			 --  - x
			--[[ if getElementModel(v) == 545 then
			setVehicleHandling(v, "maxVelocity", 580)
				setVehicleHandling(v, "engineAcceleration", 75)
				setVehicleHandling(v, "engineInertia", 46.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 390.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.61)
                setVehicleHandling(v, "tractionLoss", 0.83)
                setVehicleHandling(v, "tractionBias", 0.45)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.3, -0.5})
				setVehicleHandling(v, "suspensionDamping", 0.2)
				setVehicleHandling(v, "suspensionForceLevel", 1.05)
				setVehicleHandling(v, "mass", 1650)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.4) --Dőlésszög az eleje és hátulja között
			 end	--]]
			 -- ZR-350 - x Ferrari F355
			 if getElementModel(v) == 477 then
				setVehicleHandling(v, "maxVelocity", 230)
				setVehicleHandling(v, "engineAcceleration", 25)
				setVehicleHandling(v, "engineInertia", 46.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 390.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.58)
                setVehicleHandling(v, "tractionLoss", 0.93)
                setVehicleHandling(v, "tractionBias", 0.36)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.3, -0.3})
				setVehicleHandling(v, "suspensionDamping", 0.2)
				setVehicleHandling(v, "suspensionForceLevel", 0.75)
				setVehicleHandling(v, "mass", 1550)
			 end	
			 -- Vincent x       Subaru Impreza ST
			 if getElementModel(v) == 540 then 
				setVehicleHandling(v, "maxVelocity", 240 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 20 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 30 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 1 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "brakeDeceleration", 390.0)
		setVehicleHandling(v, "tractionLoss", 1.1 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.75 )--kerék-karosszéria táv
			 end		 
			 -- Sweeper x
		--[[	 if getElementModel(v) == 574 then
				setVehicleHandling(v, "maxVelocity", 105)
				setVehicleHandling(v, "engineAcceleration", 6.0)
				setVehicleHandling(v, "engineInertia", 30.5)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 15.0)
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 0.92)
                setVehicleHandling(v, "tractionLoss", 0.82)
                setVehicleHandling(v, "tractionBias", 0.52)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.2, -0.08})
				setVehicleHandling(v, "mass", 1500)
				setVehicleHandling(v, "turnMass", 2400.0)
				setVehicleHandling(v, "suspensionForceLevel", 1.3)
				setVehicleHandling(v, "suspensionDamping", 0.5)
			 end	--]]
			 -- Elegant x 		Mercedes Benz E500
			 if getElementModel(v) == 507 then
				setVehicleHandling(v, "maxVelocity", 200 ) --- végsebesség most 500
				setVehicleHandling(v, "engineAcceleration", 14 ) --- gyorsulás most 30
				setVehicleHandling(v, "tractionMultiplier", 0.8 ) --- kanyarodás most 0.5
				setVehicleHandling(v, "tractionLoss", 1 ) --- fékezés most 2		
				setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.45} )
				setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
				setVehicleHandling(v, "suspensionFrontRearBias", 0.44) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 1.1 )--kerék-karosszéria táv növelés  plusz pattogá
			 end	
			 
			 -- Regina - x         --------- Aston Martin DBX
			 if getElementModel(v) == 479 then
				setVehicleHandling(v, "maxVelocity", 210 ) --- végsebesség most 300 a vége
		setVehicleHandling(v, "engineAcceleration", 25 ) --- gyorsulás most 30
		setVehicleHandling(v, "engineInertia", 60 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.95 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "brakeDeceleration", 590)
		setVehicleHandling(v, "brakeBias", 39)
		setVehicleHandling(v, "tractionLoss", 1.3 ) --- fékezés most 2		
		setVehicleHandling(v, "centerOfMass", {0.0, 0.0, -0.7} )
		setVehicleHandling(v, "driveType", "awd") --- végsebesség most 500
		setVehicleHandling(v, "suspensionFrontRearBias", 0.46) --Dőlésszög az eleje és hátulja között
		setVehicleHandling(v, "suspensionForceLevel", 0.85 )--kerék-karosszéria táv
             end		
		-- Feltzer x			Porsche 718 Boxter S
			 if getElementModel(v) == 533 then
				setVehicleHandling(v, "maxVelocity", 280)
				setVehicleHandling(v, "engineAcceleration", 24)
				setVehicleHandling(v, "engineInertia", 37.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 390.0)
				setVehicleHandling(v, "ABS", true)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "steeringLock", 30.0)
				setVehicleHandling(v, "tractionMultiplier", 1.45)
                setVehicleHandling(v, "tractionLoss", 0.93)
                setVehicleHandling(v, "tractionBias", 0.46)
				setVehicleHandling(v, "centerOfMass", { 0.0, -0.1, -0.5})
				setVehicleHandling(v, "suspensionDamping", 0.2)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.45) --Dőlésszög az eleje és hátulja között
				setVehicleHandling(v, "suspensionForceLevel", 0.9)
				setVehicleHandling(v, "mass", 1550)
			 end	
			 
			-- Security car pénzszállító
			if getElementModel(v) == 428 then 									
				setVehicleHandling(v, "maxVelocity", 30 ) --- végsebesség most 500
		setVehicleHandling(v, "engineAcceleration", 5 ) --- gyorsulás most 30
		setVehicleHandling(v, "tractionMultiplier", 0.5 ) --- kanyarodás most 0.5
		setVehicleHandling(v, "tractionLoss", 0.4 ) --- fékezés most 2		
		
			end
			 
			 -- Bravura
				if getElementModel(v) == 586 then
				setVehicleHandling(v, "maxVelocity", 164)
				setVehicleHandling(v, "engineAcceleration", 30.0)
				setVehicleHandling(v, "engineInertia", 5.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.8)
                setVehicleHandling(v, "tractionLoss", 1.15)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 19.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.09})
				setVehicleHandling(v, "dragCoeff",0.0)
			end	
			
			 -- 
			 if getElementModel(v) == 468 then
				setVehicleHandling(v, "maxVelocity", 197)
				setVehicleHandling(v, "engineAcceleration", 40.0)
				setVehicleHandling(v, "engineInertia", 5.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.8)
                setVehicleHandling(v, "tractionLoss", 1.15)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 19.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.09})
				setVehicleHandling(v, "dragCoeff",0.0)
			end	
			  -- FCR-900 - x
		if getElementModel(v) == 521 then
				setVehicleHandling(v, "maxVelocity", 255)
				setVehicleHandling(v, "engineAcceleration", 34.0)
				setVehicleHandling(v, "engineInertia", 5.0)
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "driveType", "rwd")
				setVehicleHandling(v, "steeringLock", 35.0)
				setVehicleHandling(v, "tractionMultiplier", 1.8)
                setVehicleHandling(v, "tractionLoss", 1.15)
                setVehicleHandling(v, "tractionBias", 0.5)
				setVehicleHandling(v, "brakeDeceleration", 18.0)
				setVehicleHandling(v, "centerOfMass", { 0.0, 0.0, -0.09})
				setVehicleHandling(v, "dragCoeff",0.0)
			end	
	--end	
end

function loadHandlings()
	for k, v in ipairs(getElementsByType("vehicle")) do
		loadHandling(v)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHandlings)

function vehicleEnter()
	--loadHandling(source)
end
addEventHandler("onVehicleEnter", getRootElement(), vehicleEnter)

-- function resetHandling()
	-- for k, v in ipairs(getElementsByType("vehicle")) do
		-- for k1,v1 in ipairs(setModelHandling(getVehicleModel(v))) do
			-- setVehicleHandling(v, k1, nil)
		-- end
	-- end
-- end
-- addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), resetHandling)