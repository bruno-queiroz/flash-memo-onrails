@react.component
let make = () => {
  <>
    <Header />
    <ReactRouter.Routes>
      <ReactRouter.Route path="/decks" element={<Decks />} />
      <ReactRouter.Route path="/add" element={<AddCard />} />
    </ReactRouter.Routes>
  </>
}
