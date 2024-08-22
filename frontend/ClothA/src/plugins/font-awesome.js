
//svg core
import { library } from '@fortawesome/fontawesome-svg-core'

//vue -fontawesome library
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

/* import specific icons */

import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'

library.add(fas);
library.add(far);
library.add(fab);


export default FontAwesomeIcon;