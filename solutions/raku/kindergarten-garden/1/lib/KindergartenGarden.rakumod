constant %PLANTS = 
    :C<clover>,
    :G<grass>,
    :R<radishes>,
    :V<violets>;
sub plants (:$diagram, :$student) is export {
    %PLANTS{$diagram.lines>>.comb>>[($student.ord - 65) * 2 + ^2].flat}
}