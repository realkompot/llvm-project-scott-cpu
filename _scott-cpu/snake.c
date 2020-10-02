//===----------------------------------------------------------------------===//
// These functions are expanded into IO instructions by the compiler.
//===----------------------------------------------------------------------===//
unsigned io_data_in();
void io_data_out(unsigned value);
void io_address_out(unsigned value);

//===----------------------------------------------------------------------===//
// Declarations
//===----------------------------------------------------------------------===//
typedef enum { FALSE, TRUE } Bool;
typedef enum { UP, DOWN, LEFT, RIGHT } Direction;

typedef struct {
  unsigned x;
  unsigned y;
} Coordinates;

typedef struct {
  unsigned line[8];
} CellPattern;

unsigned shift(unsigned, unsigned, Bool);
unsigned multiply(unsigned, unsigned);
unsigned random(unsigned);
void prepare_multiplication_table();
void set_cell_content(const Coordinates*, const CellPattern*);
Bool is_cell_occupied(const Coordinates*);
void fill_level();
unsigned next_index(unsigned);
Coordinates next_head_position();
void move_snake(Coordinates);
void grow_snake(Coordinates);
void initialize_snake();
void kill_snake();
void poll_input();
void show_next_apple();

//===----------------------------------------------------------------------===//
// Constants
//===----------------------------------------------------------------------===//
const unsigned DISPLAY_ADDR = 0x7;
const unsigned KEY_ADAPTER_ADDR = 0xF;
const unsigned MAX_SNAKE_LENGTH = 200;
const unsigned GRID_WIDTH = 30;
const unsigned GRID_HEIGHT = 20;
const unsigned KEY_LEFT = 263;
const unsigned KEY_RIGHT = 262;
const unsigned KEY_UP = 265;
const unsigned KEY_DOWN = 264;
const CellPattern APPLE_PATTERN = {
  .line = {
    0b00101000,
    0b00010000,
    0b00001000,
    0b00111100,
    0b01111110,
    0b01111110,
    0b01111110,
    0b00111100
  }
};
const CellPattern SNAKE_PATTERN = {
  .line = {
    0b01111110,
    0b11111111,
    0b11000011,
    0b11000011,
    0b11000011,
    0b11000011,
    0b11111111,
    0b01111110
  }
};
const CellPattern WALL_PATTERN = {
  .line = {
    0b00000000,
    0b01111110,
    0b01000010,
    0b01011010,
    0b01011010,
    0b01000010,
    0b01111110,
    0b00000000
  }
};
const CellPattern EMPTY_PATTERN = {
  .line = { 0, 0, 0, 0, 0, 0, 0, 0 }
};
const unsigned LEVEL_DATA_ITEM_LENGTH = 15;
const unsigned LEVEL[] = {
  0b111111111111111, 0b111111111111111,
  0b100000000000000, 0b000000000000001,
  0b100000000000000, 0b000000000000001,
  0b100000000000000, 0b000000000000001,
  0b100001111110000, 0b000011111100001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100000000000000, 0b000000000000001,
  0b100000000000000, 0b000000000000001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100001000000000, 0b000000000100001,
  0b100001111110000, 0b000011111100001,
  0b100000000000000, 0b000000000000001,
  0b100000000000000, 0b000000000000001,
  0b100000000000000, 0b000000000000001,
  0b111111111111111, 0b111111111111111,
};

//===----------------------------------------------------------------------===//
// Globals
//===----------------------------------------------------------------------===//
Coordinates snake[MAX_SNAKE_LENGTH];
unsigned head_index = 0, tail_index = 0;
Direction direction = RIGHT;
Coordinates apple;

// This array contains information whether a cell is empty or not, needed to check collisions.
// Can't use 2-dimensional array here because the compiler will use 'mul' to calculate offsets into it.
Bool grid[GRID_WIDTH * GRID_HEIGHT];

// Pre-prepared i*30 and i*8*30 multiplication results.
// Using them is much faster than computing every time.
unsigned multiplication_table_one_row[GRID_HEIGHT];
unsigned multiplication_table_eight_rows[GRID_HEIGHT];

//===----------------------------------------------------------------------===//
// Functions. Execution starts with the first defined function regardless of its name.
//===----------------------------------------------------------------------===//
int main()
{
  io_address_out(DISPLAY_ADDR);
  prepare_multiplication_table();
  fill_level();
  initialize_snake();
  show_next_apple();

  while (TRUE)
  {
    poll_input();

    Coordinates next_head = next_head_position();

    if (is_cell_occupied(&next_head)) {
      Bool is_apple = next_head.x == apple.x && next_head.y == apple.y;

      if (is_apple) {
        grow_snake(next_head);
        show_next_apple();
      } else {
        kill_snake();
        initialize_snake();
      }
    } else {
      move_snake(next_head);
    }
  }

  return 0;
}

void grow_snake(Coordinates new_head_position)
{
  head_index = next_index(head_index);
  snake[head_index] = new_head_position;
  set_cell_content(&snake[head_index], &SNAKE_PATTERN);
}

void move_snake(Coordinates new_head_position)
{
  // Draw new head first.
  head_index = next_index(head_index);
  snake[head_index] = new_head_position;
  set_cell_content(&snake[head_index], &SNAKE_PATTERN);

  // Erase the tail and increment index.
  set_cell_content(&snake[tail_index], &EMPTY_PATTERN);
  tail_index = next_index(tail_index);
}

void kill_snake()
{
  unsigned erase_to_index = next_index(head_index);

  while (tail_index != erase_to_index)
  {
    set_cell_content(&snake[tail_index], &EMPTY_PATTERN);
    tail_index = next_index(tail_index);
  }
}

Coordinates next_head_position()
{
  Coordinates result = snake[head_index];

  switch (direction)
  {
    case UP:
      result.y--;
    break;
    case DOWN:
      result.y++;
    break;
    case LEFT:
      result.x--;
    break;
    case RIGHT:
      result.x++;
    break;
  }

  return result;
}

void initialize_snake()
{
  head_index = 0;
  Coordinates coords = {.x = 1, .y = 1};
  grow_snake(coords);
  coords.x = 2;
  grow_snake(coords);
  coords.x = 3;
  grow_snake(coords);
  tail_index = 1;
  direction = RIGHT;
}

void show_next_apple()
{
  Coordinates apple_candidate;
  do
  {
    apple_candidate.x = random(GRID_WIDTH);
    apple_candidate.y = random(GRID_HEIGHT);
  } while (is_cell_occupied(&apple_candidate));

  apple.x = apple_candidate.x;
  apple.y = apple_candidate.y;
  set_cell_content(&apple, &APPLE_PATTERN);
}

void fill_level()
{
  Coordinates coords;
  unsigned index = 0;
  unsigned x = 0;
  for (unsigned y = 0; y < GRID_HEIGHT; y++)
  {
    x = 0;
    while (x < GRID_WIDTH)
    {
      unsigned bits = LEVEL[index];
      for (unsigned bit_counter = 0; bit_counter < LEVEL_DATA_ITEM_LENGTH; bit_counter++)
      {
        if (bits & 1 << (LEVEL_DATA_ITEM_LENGTH - 1))
        {
          coords.x = x;
          coords.y = y;
          set_cell_content(&coords, &WALL_PATTERN);
        }

        bits <<= 1;
        x++;
      }
      index++;
    }
  }
}

void set_cell_content(const Coordinates *coords, const CellPattern *pattern)
{
  unsigned caret = multiplication_table_eight_rows[(*coords).y] + (*coords).x;

  for (unsigned i = 0; i < 8; i++)
  {
    io_data_out(caret);
    io_data_out((*pattern).line[i]);
    caret += GRID_WIDTH;
  }

  // Mark the cell as "occupied".
  unsigned grid_index = multiplication_table_one_row[(*coords).y] + (*coords).x;
  Bool occupied = pattern != &EMPTY_PATTERN;
  grid[grid_index] = occupied;
}

Bool is_cell_occupied(const Coordinates *coords)
{
  unsigned grid_index = multiplication_table_one_row[(*coords).y] + (*coords).x;
  return grid[grid_index];
}

unsigned next_index(unsigned index)
{
  return index < MAX_SNAKE_LENGTH - 1 ? index + 1 : 0;
}

void poll_input()
{
  io_address_out(KEY_ADAPTER_ADDR);
  unsigned key = io_data_in();

  switch (key) {
    case KEY_UP:
      direction = direction == LEFT || direction == RIGHT ? UP : direction;
      break;
    case KEY_DOWN:
      direction = direction == LEFT || direction == RIGHT ? DOWN : direction;
    break;
    case KEY_LEFT:
      direction = direction == DOWN || direction == UP ? LEFT : direction;
    break;
    case KEY_RIGHT:
      direction = direction == DOWN || direction == UP ? RIGHT : direction;
    break;
  }

  io_address_out(DISPLAY_ADDR);
}

void prepare_multiplication_table()
{
  for (unsigned i = 0; i < GRID_HEIGHT; i++)
  {
    multiplication_table_one_row[i] = multiply(i, GRID_WIDTH);
    multiplication_table_eight_rows[i] = multiply(i, GRID_WIDTH * 8);
  }
}

// A 16-bit xorshift implementation.
// http://b2d-f9r.blogspot.com/2010/08/16-bit-xorshift-rng-now-with-more.html
unsigned random(unsigned limit)
{
  static unsigned x = 1, y = 1;
  unsigned result;

  do {
    unsigned t = x ^ shift(x, 5, TRUE);
    x = y;
    y = (y ^ (y >> 1)) ^ (t ^ shift(t, 3, FALSE));
    result = y & 0x1F;
  } while (result >= limit);

  return result;
}

// Clang folds this function to the 'mul' instruction when compiled with -O3.
// While it is amazing that it manages to infer this, the CPU doesn't support multiplication.
// Hence the optnone attribute to disable optimizations.
unsigned __attribute__((optnone)) multiply(unsigned a, unsigned b)
{
   unsigned c = 0, one;
   while(b > 0)
   {
     one = (b & 1);
     if (one > 0)
        c += a;
     a <<= 1;
     b >>= 1;
   }

   return c;
}

// Mark this one with optnone as well because clang is too smart.
// It converts a loop of shifts by 1 to a single shift by N. The CPU only supports shifting by one.
unsigned __attribute__((optnone)) shift(unsigned number, unsigned shift, Bool shift_left)
{
  unsigned result = number;
  for (unsigned i = 0; i < shift; i++)
  {
    result = shift_left ? result << 1 : result >> 1;
  }
  return result;
}
