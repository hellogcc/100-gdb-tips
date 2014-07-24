# 打印源代码行

## 例子

	$ gdb -q `which gdb`
	(gdb) l
	15	
	16	   You should have received a copy of the GNU General Public License
	17	   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
	18	
	19	#include "defs.h"
	20	#include "main.h"
	21	#include <string.h>
	22	#include "interps.h"
	23	
	24	int

## 技巧

如上所示，在gdb中可以使用`list`（简写为l）命令来显示源代码以及行号。`list`命令可以指定行号，函数：

	(gdb) l 24
	(gdb) l main

还可以指定向前或向后打印：

	(gdb) l -
	(gdb) l +

还可以指定范围：

	(gdb) l 1,10

详情参见[gdb手册](https://sourceware.org/gdb/onlinedocs/gdb/List.html#List)

## 贡献者

xmj

