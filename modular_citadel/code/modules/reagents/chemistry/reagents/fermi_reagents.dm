 //Fermichem!!
//Fun chems for all the family

/datum/reagent/fermi
	name = "Fermi" //This should never exist, but it does so that it can exist in the case of errors..
	id = "fermi"
	taste_description	= "affection and love!"
	can_synth = FALSE
	//SplitChem = TRUE
	impure_chem 			= "fermiTox"// What chemical is metabolised with an inpure reaction
	inverse_chem_val 		= 0.25		// If the impurity is below 0.5, replace ALL of the chem with inverse_chemupon metabolising
	inverse_chem			= "fermiTox"

//This should process fermichems to find out how pure they are and what effect to do.
/datum/reagent/fermi/on_mob_add(mob/living/carbon/M, amount)
	. = ..()


//When merging two fermichems, see above
/datum/reagent/fermi/on_merge(data, amount, mob/living/carbon/M, purity)//basically on_mob_add but for merging
	. = ..()



////////////////////////////////////////////////////////////////////////////////////////////////////
//										HATIMUIM
///////////////////////////////////////////////////////////////////////////////////////////////////
//Adds a heat upon your head, and tips their hat
//Also has a speech alteration effect when the hat is there
//Increase armour; 1 armour per 10u
//but if you OD it becomes negative.


/datum/reagent/fermi/hatmium //for hatterhat
	name = "Hat growth serium"
	id = "hatmium"
	description = "A strange substance that draws in a hat from the hat dimention."
	color = "#7c311a" // rgb: , 0, 255
	taste_description = "like jerky, whiskey and an off aftertaste of a crypt."
	metabolization_rate = 0.2
	overdose_threshold = 25
	chemical_flags = REAGENT_DONOTSPLIT
	pH = 4
	can_synth = TRUE


/datum/reagent/fermi/hatmium/on_mob_add(mob/living/carbon/human/M)
	. = ..()
	if(M.head)
		var/obj/item/W = M.head
		if(istype(W, /obj/item/clothing/head/hattip))
			qdel(W)
		else
			M.dropItemToGround(W, TRUE)
	var/hat = new /obj/item/clothing/head/hattip()
	M.equip_to_slot(hat, SLOT_HEAD, 1, 1)


/datum/reagent/fermi/hatmium/on_mob_life(mob/living/carbon/human/M)
	if(!istype(M.head, /obj/item/clothing/head/hattip))
		return ..()
	var/hatArmor = 0
	if(!overdosed)
		hatArmor = (purity/10)
	else
		hatArmor = - (purity/10)
	if(hatArmor > 90)
		return ..()
	var/obj/item/W = M.head
	W.armor = W.armor.modifyAllRatings(hatArmor)
	..()

///////////////////////////////////////////////////////////////////////////////////////////////
//Nanite removal
//Writen by Trilby!! Embellsished a little by me.

/datum/reagent/fermi/nanite_b_gone
	name = "Nanite bane"
	id = "nanite_b_gone"
	description = "A stablised EMP that is highly volatile, shocking small nano machines that will kill them off at a rapid rate in a patient's system."
	color = "#708f8f"
	overdose_threshold = 15
	impure_chem 			= "nanite_b_goneTox" //If you make an inpure chem, it stalls growth
	inverse_chem_val 		= 0.25
	inverse_chem		= "nanite_b_goneTox" //At really impure vols, it just becomes 100% inverse
	taste_description = "what can only be described as licking a battery."
	pH = 9
	can_synth = FALSE

/datum/reagent/fermi/nanite_b_gone/on_mob_life(mob/living/carbon/C)
	//var/component/nanites/N = M.GetComponent(/datum/component/nanites)
	GET_COMPONENT_FROM(N, /datum/component/nanites, C)
	if(isnull(N))
		return ..()
	N.nanite_volume = -purity//0.5 seems to be the default to me, so it'll neuter them.
	..()

/datum/reagent/fermi/nanite_b_gone/overdose_process(mob/living/carbon/C)
	//var/component/nanites/N = M.GetComponent(/datum/component/nanites)
	GET_COMPONENT_FROM(N, /datum/component/nanites, C)
	if(prob(5))
		to_chat(C, "<span class='warning'>The residual voltage from the nanites causes you to seize up!</b></span>")
		C.electrocute_act(10, (get_turf(C)), 1, FALSE, FALSE, FALSE, TRUE)
	if(prob(10))
		//empulse((get_turf(C)), 3, 2)//So the nanites randomize
		var/atom/T = C
		T.emp_act(EMP_HEAVY)
		to_chat(C, "<span class='warning'>You feel a strange tingling sensation come from your core.</b></span>")
	if(isnull(N))
		return ..()
	N.nanite_volume = -2
	..()

/datum/reagent/fermi/nanite_b_gone/reaction_obj(obj/O, reac_volume)
	O.emp_act(EMP_HEAVY)

/datum/reagent/fermi/nanite_b_goneTox
	name = "Electromagnetic crystals"
	id = "nanite_b_goneTox"
	description = "Causes items upon the patient to sometimes short out, as well as causing a shock in the patient, if the residual charge between the crystals builds up to sufficient quantities"
	metabolization_rate = 0.5
	chemical_flags = REAGENT_INVISIBLE

//Increases shock events.
/datum/reagent/fermi/nanite_b_goneTox/on_mob_life(mob/living/carbon/C)//Damages the taker if their purity is low. Extended use of impure chemicals will make the original die. (thus can't be spammed unless you've very good)
	if(prob(15))
		to_chat(C, "<span class='warning'>The residual voltage in your system causes you to seize up!</b></span>")
		C.electrocute_act(10, (get_turf(C)), 1, FALSE, FALSE, FALSE, TRUE)
	if(prob(50))
		var/atom/T = C
		T.emp_act(EMP_HEAVY)
		to_chat(C, "<span class='warning'>You feel your hair stand on end as you glow brightly for a moment!</b></span>")
	..()


///////////////////////////////////////////////////////////////////////////////////////////////
//				MISC FERMICHEM CHEMS FOR SPECIFIC INTERACTIONS ONLY
///////////////////////////////////////////////////////////////////////////////////////////////

/datum/reagent/fermi/fermiAcid
	name = "Acid vapour"
	id = "fermiAcid"
	description = "Someone didn't do like an otter, and add acid to water."
	taste_description = "acid burns, ow"
	color = "#FFFFFF"
	pH = 0
	can_synth = FALSE

/datum/reagent/fermi/fermiAcid/reaction_mob(mob/living/carbon/C, method)
	var/target = C.get_bodypart(BODY_ZONE_CHEST)
	var/acidstr
	if(!C.reagents.pH || C.reagents.pH >5)
		acidstr = 3
	else
		acidstr = ((5-C.reagents.pH)*2) //runtime - null.pH ?
	C.adjustFireLoss(acidstr/2, 0)
	if((method==VAPOR) && (!C.wear_mask))
		if(prob(20))
			to_chat(C, "<span class='warning'>You can feel your lungs burning!</b></span>")
		C.adjustOrganLoss(ORGAN_SLOT_LUNGS, acidstr*2)
		C.apply_damage(acidstr/5, BURN, target)
	C.acid_act(acidstr, volume)
	..()

/datum/reagent/fermi/fermiAcid/reaction_obj(obj/O, reac_volume)
	if(ismob(O.loc)) //handled in human acid_act()
		return
	if((holder.pH > 5) || (volume < 0.1)) //Shouldn't happen, but just in case
		return
	reac_volume = round(volume,0.1)
	var/acidstr = (5-holder.pH)*2 //(max is 10)
	O.acid_act(acidstr, volume)
	..()

/datum/reagent/fermi/fermiAcid/reaction_turf(turf/T, reac_volume)
	if (!istype(T))
		return
	reac_volume = round(volume,0.1)
	var/acidstr = (5-holder.pH)
	T.acid_act(acidstr, volume)
	..()

/datum/reagent/fermi/fermiTest
	name = "Fermis Test Reagent"
	id = "fermiTest"
	description = "You should be really careful with this...! Also, how did you get this?"
	chemical_flags = REAGENT_FORCEONNEW
	can_synth = FALSE

/datum/reagent/fermi/fermiTest/on_new(datum/reagents/holder)
	..()
	if(LAZYLEN(holder.reagent_list) == 1)
		return
	else
		holder.remove_reagent("fermiTest", volume)//Avoiding recurrsion
	var/location = get_turf(holder.my_atom)
	if(purity < 0.34 || purity == 1)
		var/datum/effect_system/foam_spread/s = new()
		s.set_up(volume*2, location, holder)
		s.start()
	if((purity < 0.67 && purity >= 0.34)|| purity == 1)
		var/datum/effect_system/smoke_spread/chem/s = new()
		s.set_up(holder, volume*2, location)
		s.start()
	if(purity >= 0.67)
		for (var/datum/reagent/reagent in holder.reagent_list)
			if (istype(reagent, /datum/reagent/fermi))
				var/datum/chemical_reaction/fermi/Ferm  = GLOB.chemical_reagents_list[reagent.id]
				Ferm.FermiExplode(src, holder.my_atom, holder, holder.total_volume, holder.chem_temp, holder.pH)
			else
				var/datum/chemical_reaction/Ferm  = GLOB.chemical_reagents_list[reagent.id]
				Ferm.on_reaction(holder, reagent.volume)
	for(var/mob/M in viewers(8, location))
		to_chat(M, "<span class='danger'>The solution reacts dramatically, with a meow!</span>")
		playsound(get_turf(M), 'modular_citadel/sound/voice/merowr.ogg', 50, 1)
	holder.clear_reagents()

/datum/reagent/fermi/acidic_buffer
	name = "Acidic buffer"
	id = "acidic_buffer"
	description = "This reagent will consume itself and move the pH of a beaker towards acidity when added to another."
	color = "#fbc314"
	pH = 0
	can_synth = TRUE

//Consumes self on addition and shifts pH
/datum/reagent/fermi/acidic_buffer/on_new(datapH)
	if(holder.has_reagent("stabilizing_agent"))
		return ..()
	data = datapH
	if(LAZYLEN(holder.reagent_list) == 1)
		return ..()
	holder.pH = ((holder.pH * holder.total_volume)+(pH * (volume)))/(holder.total_volume + (volume))
	var/list/seen = viewers(5, get_turf(holder))
	for(var/mob/M in seen)
		to_chat(M, "<span class='warning'>The beaker fizzes as the pH changes!</b></span>")
	playsound(get_turf(holder.my_atom), 'sound/FermiChem/bufferadd.ogg', 50, 1)
	holder.remove_reagent(id, volume, ignore_pH = TRUE)
	..()

/datum/reagent/fermi/basic_buffer
	name = "Basic buffer"
	id = "basic_buffer"
	description = "This reagent will consume itself and move the pH of a beaker towards alkalinity when added to another."
	color = "#3853a4"
	pH = 14
	can_synth = TRUE

/datum/reagent/fermi/basic_buffer/on_new(datapH)
	if(holder.has_reagent("stabilizing_agent"))
		return ..()
	data = datapH
	if(LAZYLEN(holder.reagent_list) == 1)
		return ..()
	holder.pH = ((holder.pH * holder.total_volume)+(pH * (volume)))/(holder.total_volume + (volume))
	var/list/seen = viewers(5, get_turf(holder))
	for(var/mob/M in seen)
		to_chat(M, "<span class='warning'>The beaker froths as the pH changes!</b></span>")
	playsound(get_turf(holder.my_atom), 'sound/FermiChem/bufferadd.ogg', 50, 1)
	holder.remove_reagent(id, volume, ignore_pH = TRUE)
	..()

//Turns you into a cute catto while it's in your system.
//If you manage to gamble perfectly, makes you have cat ears after you transform back. But really, you shouldn't end up with that with how random it is.
/datum/reagent/fermi/secretcatchem //Should I hide this from code divers? A secret cit chem?
	name = "secretcatchem" //an attempt at hiding it
	id = "secretcatchem"
	description = "An illegal and hidden chem that turns people into cats. It's said that it's so rare and unstable that having it means you've been blessed."
	taste_description = "hairballs and cream"
	color = "#ffc224"
	var/catshift = FALSE
	var/mob/living/simple_animal/pet/cat/custom_cat/catto = null
	can_synth = FALSE

/datum/reagent/fermi/secretcatchem/New()
	name = "Catbalti[pick("a","u","e","y")]m [pick("apex", "prime", "meow")]"//rename

/datum/reagent/fermi/secretcatchem/on_mob_add(mob/living/carbon/human/H)
	. = ..()
	if(purity >= 0.8)//ONLY if purity is high, and given the stuff is random. It's very unlikely to get this to 1. It already requires felind too, so no new functionality there.
		//exception(al) handler:
		H.dna.features["ears"]  = "Cat"
		H.dna.features["mam_ears"] = "Cat"
		H.verb_say = "mewls"
		catshift = TRUE
		playsound(get_turf(H), 'modular_citadel/sound/voice/merowr.ogg', 50, 1, -1)
	to_chat(H, "<span class='notice'>You suddenly turn into a cat!</span>")
	catto = new(get_turf(H.loc))
	H.mind.transfer_to(catto)
	catto.name = H.name
	catto.desc = "A cute catto! They remind you of [H] somehow."
	catto.color = "#[H.dna.features["mcolor"]]"
	catto.pseudo_death = TRUE
	H.forceMove(catto)
	log_game("FERMICHEM: [H] ckey: [H.key] has been made into a cute catto.")
	SSblackbox.record_feedback("tally", "fermi_chem", 1, "cats")
	//Just to deal with rascally ghosts
	//ADD_TRAIT(catto, TRAIT_NODEATH, "catto")//doesn't work
	//catto.health = 1000 //To simulate fake death, while preventing ghosts escaping.

/datum/reagent/fermi/secretcatchem/on_mob_life(mob/living/carbon/H)
	if(catto.health <= 0) //So the dead can't ghost
		if(prob(10))
			to_chat(H, "<span class='notice'>You feel your body start to slowly shift back from it's dead form.</span>")
	else if(prob(5))
		playsound(get_turf(catto), 'modular_citadel/sound/voice/merowr.ogg', 50, 1, -1)
		catto.say("lets out a meowrowr!*")
	..()

/datum/reagent/fermi/secretcatchem/on_mob_delete(mob/living/carbon/H)
	var/words = "Your body shifts back to normal."
	H.forceMove(catto.loc)
	catto.mind.transfer_to(H)
	if(catshift == TRUE)
		words += " ...But wait, are those cat ears?"
		H.say("*wag")//force update sprites.
	to_chat(H, "<span class='notice'>[words]</span>")
	qdel(catto)
	log_game("FERMICHEM: [H] ckey: [H.key] has returned to normal")
