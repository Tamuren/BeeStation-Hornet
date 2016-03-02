/mob/living/carbon/alien/humanoid/royal/praetorian
	name = "alien praetorian"
	caste = "p"
	maxHealth = 250
	health = 250
	icon_state = "alienp"



/mob/living/carbon/alien/humanoid/royal/praetorian/New()

	real_name = name

	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/acid
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse/xeno(src))
	AddAbility(new /obj/effect/proc_holder/alien/royal/praetorian/evolve())
	..()

/mob/living/carbon/alien/humanoid/royal/praetorian/handle_hud_icons_health()
	if (healths)
		if(stat != DEAD)
			switch(health)
				if(250 to INFINITY)
					healths.icon_state = "health0"
				if(200 to 250)
					healths.icon_state = "health1"
				if(150 to 200)
					healths.icon_state = "health2"
				if(100 to 150)
					healths.icon_state = "health3"
				if(50 to 100)
					healths.icon_state = "health4"
				if(0 to 50)
					healths.icon_state = "health5"
				else
					healths.icon_state = "health6"
		else
			healths.icon_state = "health7"


/mob/living/carbon/alien/humanoid/royal/praetorian/movement_delay()
	. = ..()
	. += 1

/obj/effect/proc_holder/alien/royal/praetorian/evolve
	name = "Evolve"
	desc = "Produce an interal egg sac capable of spawning children. Only one queen can exist at a time."
	plasma_cost = 500

	action_icon_state = "alien_evolve_praetorian"

/obj/effect/proc_holder/alien/royal/praetorian/evolve/fire(mob/living/carbon/alien/humanoid/user)
	var/obj/item/organ/internal/alien/hivenode/node = user.getorgan(/obj/item/organ/internal/alien/hivenode)
	if(!node) //Just in case this particular Praetorian gets violated and kept by the RD as a replacement for Lamarr.
		user << "<span class='danger'>Without the hivemind, you would be unfit to rule as queen!</span>"
		return 0
	if(node.recent_queen_death)
		user << "<span class='danger'>You are still too burdened with guilt to evolve into a queen.</span>"
		return 0
	if(!alien_type_present(/mob/living/carbon/alien/humanoid/royal/queen))
		var/mob/living/carbon/alien/humanoid/royal/queen/new_xeno = new (user.loc)
		user.alien_evolve(new_xeno)
		return 1
	else
		user << "<span class='notice'>We already have an alive queen.</span>"
		return 0