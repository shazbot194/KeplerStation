//Strained Muscles: Temporary speed boost at the cost of rapid damage
//Limited because of hardsuits and such; ideally, used for a quick getaway

/obj/effect/proc_holder/changeling/strained_muscles
	name = "Strained Muscles"
	desc = "We evolve the ability to reduce the acid buildup in our muscles, allowing us to move much faster."
	helptext = "The strain will make us tired, and we will rapidly become fatigued. Standard weight restrictions, like hardsuits, still apply. Cannot be used in lesser form."
	chemical_cost = 15
	dna_cost = 1
	req_human = 1
	var/stacks = 0 //Increments every 5 seconds; damage increases over time
	active = 0 //Whether or not you are a hedgehog
	action_icon = 'icons/obj/implants.dmi'
	action_icon_state = "adrenal"
	action_background_icon_state = "bg_ling"

/obj/effect/proc_holder/changeling/strained_muscles/sting_action(mob/living/carbon/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	active = !active
	if(active)
		to_chat(user, "<span class='notice'>Our muscles tense and strengthen.</span>")
		changeling.chem_recharge_slowdown += 0.5
	else
		REMOVE_TRAIT(user, TRAIT_GOTTAGOFAST, "changeling_muscles")
		to_chat(user, "<span class='notice'>Our muscles relax.</span>")
		changeling.chem_recharge_slowdown -= 0.5
		if(stacks >= 20)
			to_chat(user, "<span class='danger'>We collapse in exhaustion.</span>")
			user.Knockdown(60)
			user.emote("gasp")

	INVOKE_ASYNC(src, .proc/muscle_loop, user)

	return TRUE

/obj/effect/proc_holder/changeling/strained_muscles/proc/muscle_loop(mob/living/carbon/user)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	while(active)
		ADD_TRAIT(user, TRAIT_GOTTAGOFAST, "changeling_muscles")
		if(user.stat != CONSCIOUS || user.staminaloss >= 90)
			active = !active
			to_chat(user, "<span class='notice'>Our muscles relax without the energy to strengthen them.</span>")
			user.Knockdown(40)
			REMOVE_TRAIT(user, TRAIT_GOTTAGOFAST, "changeling_muscles")
			changeling.chem_recharge_slowdown -= 0.5
			break

		stacks++
		//user.take_bodypart_damage(stacks * 0.03, 0)
		user.adjustStaminaLoss(stacks*1.3) //At first the changeling may regenerate stamina fast enough to nullify fatigue, but it will stack

		if(stacks == 10) //Warning message that the stacks are getting too high
			to_chat(user, "<span class='warning'>Our legs are really starting to hurt...</span>")

		sleep(40)

	while(!active && stacks) //Damage stacks decrease fairly rapidly while not in sanic mode
		stacks--
		sleep(20)
