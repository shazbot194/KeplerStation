
/*
	apply_damage(a,b,c)
	args
	a:damage - How much damage to take
	b:damage_type - What type of damage to take, brute, burn
	c:def_zone - Where to take the damage if its brute or burn
	Returns
	standard 0 if fail
*/
/mob/living/proc/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, break_modifier = 1)
	var/hit_percent = (100-blocked)/100
	if(!damage || (hit_percent <= 0))
		return 0
	switch(damagetype)
		if(BRUTE)
			adjustBruteLoss(damage * hit_percent)
		if(BURN)
			adjustFireLoss(damage * hit_percent)
		if(TOX)
			adjustToxLoss(damage * hit_percent)
		if(OXY)
			adjustOxyLoss(damage * hit_percent)
		if(CLONE)
			adjustCloneLoss(damage * hit_percent)
		if(STAMINA)
			adjustStaminaLoss(damage * hit_percent)
	return 1

/mob/living/proc/apply_damage_type(damage = 0, damagetype = BRUTE) //like apply damage except it always uses the damage procs
	switch(damagetype)
		if(BRUTE)
			return adjustBruteLoss(damage)
		if(BURN)
			return adjustFireLoss(damage)
		if(TOX)
			return adjustToxLoss(damage)
		if(OXY)
			return adjustOxyLoss(damage)
		if(CLONE)
			return adjustCloneLoss(damage)
		if(STAMINA)
			return adjustStaminaLoss(damage)

/mob/living/proc/get_damage_amount(damagetype = BRUTE)
	switch(damagetype)
		if(BRUTE)
			return getBruteLoss()
		if(BURN)
			return getFireLoss()
		if(TOX)
			return getToxLoss()
		if(OXY)
			return getOxyLoss()
		if(CLONE)
			return getCloneLoss()
		if(STAMINA)
			return getStaminaLoss()


/mob/living/proc/apply_damages(brute = 0, burn = 0, tox = 0, oxy = 0, clone = 0, def_zone = null, blocked = FALSE, stamina = 0, brain = 0)
	if(blocked >= 100)
		return 0
	if(brute)
		apply_damage(brute, BRUTE, def_zone, blocked)
	if(burn)
		apply_damage(burn, BURN, def_zone, blocked)
	if(tox)
		apply_damage(tox, TOX, def_zone, blocked)
	if(oxy)
		apply_damage(oxy, OXY, def_zone, blocked)
	if(clone)
		apply_damage(clone, CLONE, def_zone, blocked)
	if(stamina)
		apply_damage(stamina, STAMINA, def_zone, blocked)
	if(brain)
		apply_damage(brain, BRAIN, def_zone, blocked)
	return 1



/mob/living/proc/apply_effect(effect = 0,effecttype = EFFECT_STUN, blocked = FALSE, knockdown_stamoverride, knockdown_stammax)
	var/hit_percent = (100-blocked)/100
	if(!effect || (hit_percent <= 0))
		return 0
	switch(effecttype)
		if(EFFECT_STUN)
			Stun(effect * hit_percent)
		if(EFFECT_KNOCKDOWN)
			Knockdown(effect * hit_percent, override_stamdmg = knockdown_stammax ? CLAMP(knockdown_stamoverride, 0, knockdown_stammax-getStaminaLoss()) : knockdown_stamoverride)
		if(EFFECT_UNCONSCIOUS)
			Unconscious(effect * hit_percent)
		if(EFFECT_IRRADIATE)
			radiation += max(effect * hit_percent, 0)
		if(EFFECT_SLUR)
			slurring = max(slurring,(effect * hit_percent))
		if(EFFECT_STUTTER)
			if((status_flags & CANSTUN) && !HAS_TRAIT(src, TRAIT_STUNIMMUNE)) // stun is usually associated with stutter
				stuttering = max(stuttering,(effect * hit_percent))
		if(EFFECT_EYE_BLUR)
			blur_eyes(effect * hit_percent)
		if(EFFECT_DROWSY)
			drowsyness = max(drowsyness,(effect * hit_percent))
		if(EFFECT_JITTER)
			if((status_flags & CANSTUN) && !HAS_TRAIT(src, TRAIT_STUNIMMUNE))
				jitteriness = max(jitteriness,(effect * hit_percent))
	return 1


/mob/living/proc/apply_effects(stun = 0, knockdown = 0, unconscious = 0, irradiate = 0, slur = 0, stutter = 0, eyeblur = 0, drowsy = 0, blocked = FALSE, stamina = 0, jitter = 0, kd_stamoverride, kd_stammax)
	if(blocked >= 100)
		return 0
	if(stun)
		apply_effect(stun, EFFECT_STUN, blocked)
	if(knockdown)
		apply_effect(knockdown, EFFECT_KNOCKDOWN, blocked, kd_stamoverride, kd_stammax)
	if(unconscious)
		apply_effect(unconscious, EFFECT_UNCONSCIOUS, blocked)
	if(irradiate)
		apply_effect(irradiate, EFFECT_IRRADIATE, blocked)
	if(slur)
		apply_effect(slur, EFFECT_SLUR, blocked)
	if(stutter)
		apply_effect(stutter, EFFECT_STUTTER, blocked)
	if(eyeblur)
		apply_effect(eyeblur, EFFECT_EYE_BLUR, blocked)
	if(drowsy)
		apply_effect(drowsy, EFFECT_DROWSY, blocked)
	if(stamina)
		apply_damage(stamina, STAMINA, null, blocked)
	if(jitter)
		apply_effect(jitter, EFFECT_JITTER, blocked)
	return 1


/mob/living/proc/getBruteLoss()
	return bruteloss

/mob/living/proc/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	bruteloss = CLAMP((bruteloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/getOxyLoss()
	return oxyloss

/mob/living/proc/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	oxyloss = CLAMP((oxyloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/setOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	if(status_flags & GODMODE)
		return 0
	oxyloss = amount
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/getToxLoss()
	return toxloss

/mob/living/proc/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	toxloss = CLAMP((toxloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/setToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	toxloss = amount
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/getFireLoss()
	return fireloss

/mob/living/proc/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	fireloss = CLAMP((fireloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/getCloneLoss()
	return cloneloss

/mob/living/proc/adjustCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	cloneloss = CLAMP((cloneloss + (amount * CONFIG_GET(number/damage_multiplier))), 0, maxHealth * 2)
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/setCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	cloneloss = amount
	if(updating_health)
		updatehealth()
	return amount

/mob/living/proc/adjustOrganLoss(slot, amount, maximum)
	return

/mob/living/proc/setOrganLoss(slot, amount, maximum)
	return

/mob/living/proc/getOrganLoss(slot)
	return

/mob/living/proc/getStaminaLoss()
	return staminaloss

/mob/living/proc/adjustStaminaLoss(amount, updating_stamina = TRUE, forced = FALSE)
	return

/mob/living/proc/setStaminaLoss(amount, updating_stamina = TRUE, forced = FALSE)
	return

// heal ONE external organ, organ gets randomly selected from damaged ones.
/mob/living/proc/heal_bodypart_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE)
	adjustBruteLoss(-brute, FALSE) //zero as argument for no instant health update
	adjustFireLoss(-burn, FALSE)
	adjustStaminaLoss(-stamina, FALSE)
	if(updating_health)
		updatehealth()
	update_stamina()

// damage ONE external organ, organ gets randomly selected from damaged ones.
/mob/living/proc/take_bodypart_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE)
	adjustBruteLoss(brute, FALSE) //zero as argument for no instant health update
	adjustFireLoss(burn, FALSE)
	adjustStaminaLoss(stamina, FALSE)
	if(updating_health)
		updatehealth()
	update_stamina()

// heal MANY bodyparts, in random order
/mob/living/proc/heal_overall_damage(brute = 0, burn = 0, stamina = 0, only_robotic = FALSE, only_organic = TRUE, updating_health = TRUE)
	adjustBruteLoss(-brute, FALSE) //zero as argument for no instant health update
	adjustFireLoss(-burn, FALSE)
	adjustStaminaLoss(-stamina, FALSE)
	if(updating_health)
		updatehealth()
	update_stamina()

// damage MANY bodyparts, in random order
/mob/living/proc/take_overall_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE)
	adjustBruteLoss(brute, FALSE) //zero as argument for no instant health update
	adjustFireLoss(burn, FALSE)
	adjustStaminaLoss(stamina, FALSE)
	if(updating_health)
		updatehealth()
	update_stamina()

//heal up to amount damage, in a given order
/mob/living/proc/heal_ordered_damage(amount, list/damage_types)
	. = amount //we'll return the amount of damage healed
	for(var/i in damage_types)
		var/amount_to_heal = min(amount, get_damage_amount(i)) //heal only up to the amount of damage we have
		if(amount_to_heal)
			apply_damage_type(-amount_to_heal, i)
			amount -= amount_to_heal //remove what we healed from our current amount
		if(!amount)
			break
	. -= amount //if there's leftover healing, remove it from what we return
