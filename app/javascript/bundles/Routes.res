@react.component
let make = () => {
  <>
    <Header isUserSignedIn=true />
    <ReactRouter.Routes>
      <ReactRouter.Route path="/decks" element={<Decks />} />
      <ReactRouter.Route path="/add" element={<AddCard />} />
      <ReactRouter.Route path="/search" element={<Search />} />
    </ReactRouter.Routes>
  </>
}
