import '/exports/exports.dart';

class TableRowWidget {
  static TableRow draw(
    BuildContext context, {
    Color? color,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("#"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(""),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("P"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("W"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("D"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("L"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("GD"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("Pts"),
          ),
        ),
      ],
    );
  }

  static TableRow drawData(
    BuildContext context, {
    Color? color,
    int? id,
    int? p,
    int? w,
    int? d,
    int? l,
    int? gd,
    int? pts,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              "$id",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Image.asset(
              "assets/leagues/komafo.jpeg",
              width: 35,
              height: 35,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$p"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$w"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$d"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$l"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$gd"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text("$pts"),
          ),
        ),
      ],
    );
  }

  static DataRow drawDatRow(
    BuildContext context, {
    Color? color,
    required String image,
    required String teamName,
    int? id,
    int? p,
    int? w,
    int? d,
    int? l,
    int? gd,
    int? pts,
  }) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.w500);
    return DataRow(
      color: MaterialStateProperty.all(color),
      cells: [
        DataCell(
          SizedBox(
            // width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("$id"),
                    const SizedBox.square(
                      dimension: 2,
                    ),
                    Image.network(
                      image,
                      width: 35,
                      height: 35,
                    ),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text(teamName)
                  ],
                ),
                const SizedBox.square(
                  dimension: 30,
                ),
                Row(
                  children: [
                    Text("$p "),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text("${w?.zeros} "),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text("${d?.zeros} "),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text("${l?.zeros} "),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text("${gd?.zeros} "),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Text("${pts?.zeros} "),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
