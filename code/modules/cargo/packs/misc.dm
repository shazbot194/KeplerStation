
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Miscellaneous ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/misc
	group = "Miscellaneous Supplies"

/datum/supply_pack/misc/artsupply
	name = "Art Supplies"
	desc = "Make some happy little accidents with six canvasses, two easels, two boxes of crayons, and a rainbow crayon!"
	cost = 800
	contains = list(/obj/structure/easel,
					/obj/structure/easel,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/nineteenXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/canvas/twentythreeXnineteen,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/canvas/twentythreeXtwentythree,
					/obj/item/storage/crayons,
					/obj/item/storage/crayons,
					/obj/item/toy/crayon/rainbow,
					/obj/item/toy/crayon/white,
					/obj/item/toy/crayon/white)
	crate_name = "art supply crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/captain_pen
	name = "Captain Pen"
	desc = "A spare Captain fountain pen."
	access = ACCESS_CAPTAIN
	cost = 10000
	contains = list(/obj/item/pen/fountain/captain)
	crate_name = "captain pen"
	crate_type = /obj/structure/closet/crate/secure/weapon //It is a combat pen

/datum/supply_pack/misc/bicycle
	name = "Bicycle"
	desc = "Nanotrasen reminds all employees to never toy with powers outside their control."
	cost = 1000000
	contains = list(/obj/vehicle/ridden/bicycle)
	crate_name = "Bicycle Crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/misc/bigband
	name = "Big Band Instrument Collection"
	desc = "Get your sad station movin' and groovin' with this fine collection! Contains nine different instruments!"
	cost = 5000
	crate_name = "Big band musical instruments collection"
	contains = list(/obj/item/instrument/violin,
					/obj/item/instrument/guitar,
					/obj/item/instrument/glockenspiel,
					/obj/item/instrument/accordion,
					/obj/item/instrument/saxophone,
					/obj/item/instrument/trombone,
					/obj/item/instrument/recorder,
					/obj/item/instrument/harmonica,
					/obj/structure/piano/unanchored)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/book_crate
	name = "Book Crate"
	desc = "Surplus from the Nanotrasen Archives, these five books are sure to be good reads."
	cost = 1500
	contains = list(/obj/item/book/codex_gigas,
					/obj/item/book/manual/random/,
					/obj/item/book/manual/random/,
					/obj/item/book/manual/random/,
					/obj/item/book/random/triple)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/paper
	name = "Bureaucracy Crate"
	desc = "High stacks of papers on your desk Are a big problem - make it Pea-sized with these bureaucratic supplies! Contains five pens, some camera film, hand labeler supplies, a paper bin, three folders, two clipboards and two stamps as well as a briefcase."//that was too forced
	cost = 1500
	contains = list(/obj/structure/filingcabinet/chestdrawer/wheeled,
					/obj/item/camera_film,
					/obj/item/hand_labeler,
					/obj/item/hand_labeler_refill,
					/obj/item/hand_labeler_refill,
					/obj/item/paper_bin,
					/obj/item/pen/fourcolor,
					/obj/item/pen/fourcolor,
					/obj/item/pen,
					/obj/item/pen/blue,
					/obj/item/pen/red,
					/obj/item/folder/blue,
					/obj/item/folder/red,
					/obj/item/folder/yellow,
					/obj/item/clipboard,
					/obj/item/clipboard,
					/obj/item/stamp,
					/obj/item/stamp/denied,
					/obj/item/storage/briefcase)
	crate_name = "bureaucracy crate"

/datum/supply_pack/misc/fountainpens
	name = "Calligraphy Crate"
	desc = "Sign death warrants in style with these seven executive fountain pens."
	cost = 730
	contains = list(/obj/item/storage/box/fountainpens,
					/obj/item/paper_bin)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "calligraphy crate"

/datum/supply_pack/misc/wrapping_paper
	name = "Festive Wrapping Paper Crate"
	desc = "Want to mail your loved ones gift-wrapped chocolates, stuffed animals, the Clown's severed head? You can do all that, with this crate full of wrapping paper."
	cost = 1000
	contains = list(/obj/item/stack/wrapping_paper)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "festive wrapping paper crate"

/datum/supply_pack/misc/paper_work
	name = "Freelance Paper work"
	desc = "The Nanotrasen Primary Bureaucratic Database Intelligence (PDBI) reports that the station has not completed its funding and grant paperwork this solar cycle. In order to gain further funding, your station is required to fill out (20) ten of these forms or no additional capital will be disbursed. We have sent you ten copies of the following form and we expect every one to be up to Nanotrasen Standards." // Disbursement. It's not a typo, look it up.
	cost = 700 // Net of 0 credits but makes (120 x 20 = 2400)
	contains = list(/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/folder/paperwork,
					/obj/item/pen/fountain
					)
	crate_name = "Paperwork"

/datum/supply_pack/misc/funeral
	name = "Funeral Supply crate"
	desc = "At the end of the day, someone's gonna want someone dead. Give them a proper send-off with these funeral supplies! Contains a coffin with burial garmets and flowers."
	cost = 800
	contains = list(/obj/item/clothing/under/burial,
					/obj/item/reagent_containers/food/snacks/grown/harebell,
					/obj/item/reagent_containers/food/snacks/grown/poppy/geranium
					)
	crate_name = "coffin"
	crate_type = /obj/structure/closet/crate/coffin

/datum/supply_pack/misc/jukebox
	name = "Jukebox"
	cost = 10000
	contains = list(/obj/machinery/jukebox)
	crate_name = "Jukebox"

/datum/supply_pack/misc/religious_supplies
	name = "Religious Supplies Crate"
	desc = "Keep your local chaplain happy and well-supplied, lest they call down judgement upon your cargo bay. Contains two bottles of holywater, bibles, chaplain robes, and burial garmets."
	cost = 4000	// it costs so much because the Space Church is ran by Space Jews
	contains = list(/obj/item/reagent_containers/food/drinks/bottle/holywater,
					/obj/item/reagent_containers/food/drinks/bottle/holywater,
					/obj/item/storage/book/bible/booze,
					/obj/item/storage/book/bible/booze,
					/obj/item/clothing/suit/hooded/chaplain_hoodie,
					/obj/item/clothing/suit/hooded/chaplain_hoodie
					)
	crate_name = "religious supplies crate"

/datum/supply_pack/misc/toner
	name = "Toner Crate"
	desc = "Spent too much ink printing butt pictures? Fret not, with these six toner refills, you'll be printing butts 'till the cows come home!'"
	cost = 1000
	contains = list(/obj/item/toner,
					/obj/item/toner,
					/obj/item/toner,
					/obj/item/toner,
					/obj/item/toner,
					/obj/item/toner)
	crate_name = "toner crate"
