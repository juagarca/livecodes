// 1. Select all tiles
const tiles = document.querySelectorAll('td');
// 2. For each tile
tiles.forEach((tile) => {
  // 3. Listen to the click event
  tile.addEventListener('click', (event) => {
    if (canMove(tile)) {
      // 5. Swap the tile and the empty space
      moveTile(tile);
      // 6. Check if player wins
      setTimeout(() => checkIfPlayerWins(), 200);
    }
  });
});

const canMove = (tile) => {
  //Position of clicked tile
  const tileColumn = tile.cellIndex;
  const tileRow = tile.parentElement.rowIndex;

  // Position of empty tile
  const emptyTile = document.querySelector('.empty');
  const emptyTileColumn = emptyTile.cellIndex;
  const emptyTileRow = emptyTile.parentElement.rowIndex;

  // Returns true only if it's an adjacent tile
  return (tileColumn === emptyTileColumn && tileRow === emptyTileRow + 1) ||
    (tileColumn === emptyTileColumn && tileRow === emptyTileRow - 1) ||
    (tileRow === emptyTileRow && tileColumn === emptyTileColumn + 1) ||
    (tileRow === emptyTileRow && tileColumn === emptyTileColumn - 1);
};

const moveTile = (element) => {
  // 1. Select empty tile
  const emptyTile = document.querySelector('.empty');
  // 2. Replace its content with the `element`'s content
  emptyTile.innerText = element.innerText;
  // 2. Remove its `empty` class
  emptyTile.classList.remove('empty');
  // 4. Empty `element`'s content
  element.innerText = '';
  // 5. Add empty class to `element`
  element.classList.add('empty');
};

const checkIfPlayerWins = () => {
  // Select order of tiles
  const tilesArray = Array.from(document.querySelectorAll('td'));
  const tilesOrder = tilesArray.map((tile) => {
    return tile.innerText;
  });
  // Check if they are in correct order
  if (tilesOrder.join() === "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,") {
    alert("You win!");
  }
};

// Display hint when clicking button
const hintButton = document.querySelector('#show-hint');
const hint = document.querySelector('.hint');

hintButton.addEventListener('click', () => {
  hint.classList.toggle('active');
});
