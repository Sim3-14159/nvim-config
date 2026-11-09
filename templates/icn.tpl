procedure main(argv)
    write("You passed ", *argv, " argument(s):")
    # Iterate over the argv list
    every i := 1 to *argv do {
        write("  \033[32m", i, ".\033[0m ", argv[i])
    }

end
