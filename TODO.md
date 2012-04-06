- standardize page headers (decide h1/h2 but then move it to a helper)
- integrate bootstrap form as a 'plugin' or something
- remove gutters from everywhere -- can style the same but doesnt work
- make README sexy
- improve the @active stuff


notes by Yulia.
need new databases:
-rating
	dev_id
	overall_rating
	feedback_rating
	endorsement_rating
	scanner_rating
	prefix_rating [will be either 0 or 0.05]
	app_store_data_scraping
	third_party_data_scraping

-app feedback
	app_id
	descripton [composed from checkboxes filled out in form]
	rating [individually calculated rating per review]

-techinal app feedback
	app_id
	usability
	flexibility
	...blah [ lots of these - each category on answer - new column]
