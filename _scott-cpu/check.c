#define DISPLAY_ADDR 0x7
#define LINE_WIDTH 0x1E

int io_data_in();
void io_data_out(int value);
void io_address_out(int value);
void perform_test();
void assert(unsigned, unsigned);
void good();
void bad();

int main()
{
  io_address_out(DISPLAY_ADDR);

  while (1)
  {
    perform_test();
  }

  return 0;
}

void test_single_arg_call_target(unsigned param)
{
  assert(9, param);
}

void test_single_arg_call()
{
  test_single_arg_call_target(9);
}

unsigned test_single_arg_call_and_ret_target(unsigned param)
{
  assert(10, param);
  return 11;
}

void test_single_arg_call_and_ret()
{
  unsigned ret_val = test_single_arg_call_and_ret_target(10);

  assert(11, ret_val);
}

unsigned test_multi_arg_and_ret_target(unsigned param1, unsigned param2, unsigned param3)
{
  assert(12, param1);
  assert(13, param2);
  assert(14, param3);
  return 15;
}

void test_multi_arg_and_ret()
{
  unsigned ret_val = test_multi_arg_and_ret_target(12, 13, 14);
  assert(15, ret_val);
}

typedef struct
{
  unsigned field1;
  unsigned field2;
  unsigned field3;
} TestStruct;

void test_arg_struct_by_val_target(TestStruct param)
{
  assert(16, param.field1);
  assert(17, param.field2);
  assert(18, param.field3);
  param.field2 = 666;
}

void test_arg_struct_by_val()
{
  TestStruct val = { .field1 = 16, .field2 = 17, .field3 = 18 };

  test_arg_struct_by_val_target(val);
  assert(17, val.field2);
}

TestStruct global_var = { .field1 = 16, .field2 = 17, .field3 = 18 };

void test_arg_struct_by_val_global_var()
{
  test_arg_struct_by_val_target(global_var);
  assert(17, global_var.field2);
}

void test_multiple_struct_args_target(TestStruct param1, TestStruct param2)
{
  assert(19, param1.field1);
  assert(20, param1.field2);
  assert(21, param1.field3);
  param1.field1 = 666;

  assert(22, param2.field1);
  assert(23, param2.field2);
  assert(24, param2.field3);
  param2.field3 = 666;
}

void test_multiple_struct_args()
{
  TestStruct val1 = { .field1 = 19, .field2 = 20, .field3 = 21 };
  TestStruct val2 = { .field1 = 22, .field2 = 23, .field3 = 24 };

  test_multiple_struct_args_target(val1, val2);
  assert(19, val1.field1);
  assert(24, val2.field3);
}

TestStruct test_return_struct_by_val_target()
{
  TestStruct ret_val = { .field1 = 25, .field2 = 26, .field3 = 27 };
  return ret_val;
}

void test_return_struct_by_val()
{
  TestStruct ret_val = test_return_struct_by_val_target();
  assert(25, ret_val.field1);
  assert(26, ret_val.field2);
  assert(27, ret_val.field3);
}

TestStruct global_var_2 = { .field1 = 28, .field2 = 29, .field3 = 30 };

TestStruct test_return_global_var_struct_by_val_target()
{
  return global_var_2;
}

void test_return_global_var_struct_by_val()
{
  TestStruct ret_val = test_return_global_var_struct_by_val_target();
  global_var_2.field1 = 666;
  assert(28, ret_val.field1);
  assert(29, ret_val.field2);
  assert(30, ret_val.field3);
  assert(666, global_var_2.field1);
  global_var_2.field1 = 28;
}

TestStruct test_pass_and_return_global_var_struct_by_val_target(TestStruct param1)
{
  param1.field2 = 666;
  return param1;
}

void test_pass_and_return_global_var_struct_by_val()
{
  TestStruct val = { .field1 = 31, .field2 = 32, .field3 = 33 };
  TestStruct ret_val = test_pass_and_return_global_var_struct_by_val_target(val);

  assert(31, ret_val.field1);
  assert(666, ret_val.field2);
  assert(33, ret_val.field3);
  assert(32, val.field2);
}

void test_pass_pointer_to_modify_target(TestStruct *ptr)
{
  (*ptr).field2 = 6666;
}

void test_pass_pointer_to_modify()
{
  TestStruct val = { .field1 = 31, .field2 = 32, .field3 = 33 };
  test_pass_pointer_to_modify_target(&val);

  assert(31, val.field1);
  assert(6666, val.field2);
  assert(33, val.field3);
}

TestStruct global_array[3];

void test_pass_pointer_to_modify_2()
{
  global_array[1].field1 = 31;
  global_array[1].field2 = 32;
  global_array[1].field3 = 33;
  test_pass_pointer_to_modify_target(&global_array[1]);

  assert(31, global_array[1].field1);
  assert(6666, global_array[1].field2);
  assert(33, global_array[1].field3);
}

void test_pass_pointer_to_modify_3()
{
  TestStruct stack_array[3];
  stack_array[1].field1 = 31;
  stack_array[1].field2 = 32;
  stack_array[1].field3 = 33;
  test_pass_pointer_to_modify_target(&stack_array[1]);

  assert(31, stack_array[1].field1);
  assert(6666, stack_array[1].field2);
  assert(33, stack_array[1].field3);
}

TestStruct test_dereference_pointer_copy_target(TestStruct *ptr)
{
  TestStruct ret_val = (*ptr);
  ret_val.field2 = 666;
  return ret_val;
}

void test_dereference_pointer_copy()
{
  TestStruct val = { .field1 = 34, .field2 = 35, .field3 = 36 };
  TestStruct ret_val = test_dereference_pointer_copy_target(&val);

  assert(35, val.field2);
  assert(666, ret_val.field2);
}

typedef enum { UP, DOWN, LEFT, RIGHT } Direction;

void test_basic_switch()
{
  Direction dir = DOWN;

  switch (dir)
  {
    case UP:
    case LEFT:
    case RIGHT:
      bad();
      break;
    case DOWN:
      good();
      break;
  }
}

typedef enum { FALSE, TRUE } Bool;
Bool global_array_2[50];

Bool test_bool_array_target(unsigned index)
{
  return global_array_2[index];
}

void test_bool_array()
{
  global_array_2[15] = 5 != 1;

  if (test_bool_array_target(15)) good(); else bad();
}

void test_stack_array()
{
  unsigned test_arr[5];

  test_arr[3] = 5;
  assert(5, test_arr[3]);
}

void test_conditions()
{
  unsigned value = 36;
  if (value <  36) bad(); else good();
  if (value <= 36) good(); else bad();
  if (value <  37) good(); else bad();
  if (value >  37) bad(); else good();
  if (value >= 36) good(); else bad();
  if (value >  10) good(); else bad();

  unsigned cond = value == 36;

  if (cond) good();
  if (&value == &cond) bad();
}

void test_arithmetic()
{
  unsigned value1 = 100;
  unsigned value2 = 1;
  assert(101, value1 + value2);
  assert(99, value1 - value2);
  assert(0, value1 & value2);
  assert(200, value1 << 1);
  assert(50, value1 >> 1);

  unsigned value3 = 4095;
  if ((value3 & 512) > 0)
  {
    good();
  }else {
    bad();
  }
}

void test_loops()
{
  unsigned i = 0, res = 0;

  for (i = 1; i <= 5; i++)
  {
    res += i;
  }

  assert(15, res);

  while (i < 8)
  {
    i++;
    res += i;
  }

  assert(30, res);
}

void test_ternary()
{
  unsigned val1 = 15;
  unsigned val2 = 30;

  if (val1 > 10 ? (val2 == 31 ? 0 : 1) : 0) good(); else bad();
  if (val1 > 10 ? (val2 != 31 ? 0 : 1) : 0) bad(); else good();
}

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

void test_multiply()
{
  assert(150, multiply(30, 5));
  assert(55, multiply(55, 1));
  assert(0, multiply(5, 0));
  assert(0, multiply(0, 5));
}

unsigned recursive_func(unsigned n)
{
  if (n <= 0)
    return 0;

  return n + recursive_func(n - 2);
}

void test_recursion()
{
  unsigned result = recursive_func(7);
  assert(16, result);
}

unsigned counter;

void perform_test()
{
  counter = 0;

  test_single_arg_call();
  test_single_arg_call_and_ret();
  test_multi_arg_and_ret();
  test_arg_struct_by_val();
  test_arg_struct_by_val_global_var();
  test_multiple_struct_args();
  test_return_struct_by_val();
  test_return_global_var_struct_by_val();
  test_pass_and_return_global_var_struct_by_val();
  test_pass_pointer_to_modify();
  test_pass_pointer_to_modify_2();
  test_pass_pointer_to_modify_3();
  test_dereference_pointer_copy();
  test_basic_switch();
  test_conditions();
  test_arithmetic();
  test_loops();
  test_stack_array();
  test_bool_array();
  test_ternary();
  test_multiply();
  test_recursion();

  good();
}

void assert(unsigned expected, unsigned actual)
{
  if (expected == actual) good(); else bad();
}

void good()
{
  io_data_out(LINE_WIDTH + counter);
  io_data_out(0xFF);
  counter++;
}

void bad()
{
  io_data_out(LINE_WIDTH + counter);
  io_data_out(0x00);
  counter++;
}
