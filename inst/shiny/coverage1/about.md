A simple interactive graphical model to demonstrate how different interventions can be combined to target mosquito vectors exhibiting different behaviours, the distribution of which can change in response to those interventions.

* Select 'UI' to use. 
* Modify inputs using the sliders.
* The coloured rectangle indicates proportions of vectors feeding on humans and livestock, and proportion doing so indoors versus outdoors when they attack humans. All attacks upon livestock are assumed to occur outdoors.
* The vector feeding pie chart illustrates the proportion of vector feeding opportunities remaining available before and after scaling up these intervention options.
* The human exposure pie chart shows the proportional distribution of human exposure to biting vectors which occurs indoors and outdoors before and after scaling up these intervention options.
* The first two sliders allow you to modify the proportions of vectors feeding on livestock versus humans and, indoors versus outdoors when they do feed upon humans.
* The later sliders allow you to modify the coverage of different interventions.


This is a very simple model based on arithmetic and not directly derived from data (Kiware et al. 2012, Killeen et al. 2014). It is based on simple proportions and that interventions target vectors exhibiting different behaviour. In this implementation one intervention (bed nets) is assumed to only target vectors feeding indoors on humans, while another (insecticide vapour emanators) targets only vectors feeding outdoors upon humans, while another (veterinary insecticides) targets only vectors feeding outdoors upon livestock.

Of course, real field settings will be more complex with vectors being able to evolve altered behavioural preferences, interventions targeting more than one of these blood sources , and there being more than one vector present. Nevertheless, the model demonstrates the broad principles of how interventions can be rationally targeted to well-matched mosquito behaviours, and can create new opportunities for complementary interventions, allowing users to investigate and explore for themselves. This simple model can easily be modified to address alternative baseline assumptions, and expanded to consider more complex vector systems.

The research behind this model is described in an accompanying submitted paper.

The code is hosted here : https://github.com/AndySouth/coverage

Andy South, Gerry F. Killeen, John M. Marshall, Samson S. Kiware, Prosper P. Chaki, Nicodem J. Govella and Lucy S. Tusting

Human & Cow Icons from phylopic.org

#### References

Killeen GF. Characterizing, controlling and eliminating residual malaria transmission. Malar J 2014;13:330.

Kiware SS, Chitnis N, Devine GJ, et al. Biologically meaningful coverage indicators for eliminating malaria transmission. Biol Lett 2012;8:874-77.


