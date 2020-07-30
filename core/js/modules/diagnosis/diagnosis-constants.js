'use strict';

define({
	TYPES: {
		COMMENTS: 0,
		MISSING_PAGE: 1,
		BROKEN_IMAGE: 2,
		UNINDEXED_EXTERNAL_LINK: 3,
		BROKEN_EXTERNAL_LINK: 4,
		BROKEN_GLOSSARY_REFERENCE: 5
	},
	SEVERITY: {
		COMMENTS: 0,
		MISSING_PAGE: 1,
		BROKEN_IMAGE: 1,
		UNINDEXED_EXTERNAL_LINK: 1,
		BROKEN_EXTERNAL_LINK: 1,
		BROKEN_GLOSSARY_REFERENCE: 1
	}
});
