*** Variables ***
${data_001}       {"bannerDisplay":"slider"}    # update banner display to slider
${data_002}       {"bannerDisplay":"grid"}    # update banner display to grid
${data_003}       {"category":{"layoutProduct":2}}    #update product list to display 2 columns
${data_004}       {"category":{"layoutProduct":3}}    #update product list to display 3 columns
${data_005}       {"category":{"layoutProduct":4}}    #update product list to display 4 columns
${data_006}       {"category":{"layoutProduct":5}}    #update product list to display 5 columns
${data_007}       {"category":{"layoutProduct":6}}    #update product list to display 6 columns
${data_008}       {"category":{"autoLoad":0}}    #update product list to manual load TC027
${data_009}       {"category":{"autoLoad":1}}    #update product list to autoload TC028
${data_010}       {"category":{"visibleSidebar":1}}    #update product list to have sidebar
${data_011}       {"category":{"visibleSidebar":2}}    #update product list to have no sidebar
${data_012}       {"productDetail":{"displayWareHouse":1}}    #update product detail to display Warhouse
${data_013}       {"productDetail":{"displayWareHouse":0}}    #update product detail to not display Warhouse
${data_014}       {"productDetail":{"displayDescription":1}}    #update product detail to display Description
${data_015}       {"productDetail":{"displayDescription":0}}    #update product detail to not display Description
${data_016}       {"productDetail":{"displayComment":1}}    #update product detail to display Comment
${data_017}       {"productDetail":{"displayComment":0}}    #update product detail to not display Comment
${data_018}       {"productDetail":{"displayProductRelate":1}}    #update product detail to display Related Product
${data_019}       {"productDetail":{"displayProductRelate":0}}    #update product detail to not display Related Product
${data_reset}     {"category":{"layoutProduct":5,"autoLoad":1,"visibleSidebar":1},"productDetail":{"displayDescription":1,"displayComment":1,"displayProductRelate":1,"displayWareHouse":1}}    #update config to default
