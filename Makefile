# ------------  PROJECT  ----------------------------------------------------- #
NAME	=		#PROJECT#

# ------------  DIRECTORIES  ------------------------------------------------- #
SRC_DIR	=		#SOURCES_DIRECTORY#
HDR_DIR	=		#HEADERS_DIRECTORY#
OBJ_DIR	=		#OBJECTS_DIRECTORY#

# ------------  LIBFT  ------------------------------------------------------- #
LFT		=		libft.a
LFT_DIR	=		#LIBFT_DIRECTORY#
LHS_DIR	=		$(LIB_DIR)/#LIBFT_HEADERS_DIRECTORY#

# ------------  SOURCE FILES  ------------------------------------------------ #
SRC_FLS	=       #SOURCE_FILES#

# ------------  FILEPATHS  --------------------------------------------------- #
SRCS	=		$(addprefix $(SRC_DIR)/, $(SRC_FLS))
OBJS	=		$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o, $(SRCS))
DEPS	=		$(OBJS:.o=.d)

# ------------  FLAGS  ------------------------------------------------------- #
CC		=		gcc
RM		=		rm -rf
CFLGS	=		-Wall -Werror -Wextra
IFLGS	=		-I $(HDR_DIR) -I $(LHS_DIR)
LFLGS	=		-L $(LIB_DIR) -lft
DFLGS	=		-MMD -MP
DEBUG	=		-g -pg -fsanitize=address

# ------------  RULES  ------------------------------------------------------- #
.PHONY: all clean fclean re

all: $(NAME)

$(LIB_DIR)/$(LIB):
	$(MAKE) -C $(LIB_DIR)

-include $(DEPS)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLGS) $(DFLGS) -c -o $@ $< $(IFLGS)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(NAME): $(LIB_DIR)/$(LIB) $(OBJS)
	$(CC) -o $(NAME) $(CFLGS) $(DFLGS) $(OBJS) $(IFLGS) $(LFLGS)

clean:
	$(MAKE) -C $(LIB_DIR) clean
	$(RM) $(OBJ_DIR)

fclean: clean
	$(MAKE) -C $(LIB_DIR) fclean

re: fclean all
