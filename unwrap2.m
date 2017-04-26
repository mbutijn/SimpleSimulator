function vector_out = unwrap2(vector_in, margin)

differences = diff(vector_in);
vector_out = vector_in;
count = 0;

for i = 1:length(differences)
    if differences(i) > margin
        count = count + 1;
        vector_out(i+1:end) = vector_in(i+1:end) - count*2*pi;
        differences = diff(vector_out);
    end
end