function HomePage(){
    return(
        <>
           <div id="carouselExampleIndicators" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner mt-3">
                <div class="carousel-item active">
                <img src="https://images.saymedia-content.com/.image/ar_16:9%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:eco%2Cw_1200/MTg4MzM1NjM4NTExMTAxNDU5/best-book-series.jpg" style={{height: "500px"}}/>
                </div>
                <div class="carousel-item">
                <img src="https://static.tnn.in/thumb/msid-108327338,thumbsize-1426643,width-1280,height-720,resizemode-75/108327338.jpg?quality=100
            " class="d-block w-100" alt="..."/>
                </div>
                <div class="carousel-item">
                <img src="https://lirp.cdn-website.com/60a865d2/dms3rep/multi/opt/Colleen-Hover_It-Ends-With-Us_Book-Review-NZ_UK_US_Rating_Honest_About_Buy-1920w.jpg
            " class="d-block w-100" alt="..."/>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            </div>
        </>
    )
}

export default HomePage;


// https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT03PO9JTj8_-WxAUE02ehEJj3WoR9lPv22VA&s
// https://static.tnn.in/thumb/msid-108327338,thumbsize-1426643,width-1280,height-720,resizemode-75/108327338.jpg?quality=100
// https://lirp.cdn-website.com/60a865d2/dms3rep/multi/opt/Colleen-Hover_It-Ends-With-Us_Book-Review-NZ_UK_US_Rating_Honest_About_Buy-1920w.jpg
// https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTziOXrpnfVVkjI5PPQZIEln0MIsYWgBqNEgA&s