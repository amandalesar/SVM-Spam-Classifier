function word_indices = processEmail(email_contents)

% Load Vocabulary
vocabList = getVocabList();

% Init return value
word_indices = [];

% ========================== Preprocess Email ===========================

% For processing, make the entire email into lower case
email_contents = lower(email_contents);

% Email can sometimes contain HTML which is useless for us.
% Therefore we strip all HTML
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% We will not care what number is present in the email, just that a number
% is present
% We replace any occurence of a numerical character with
% the word 'number'
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% We will not care what URL is present in the email, just that a URL
% is present
% We replace any occurence of a URL with 'httpaddr'
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% We will not care what email address is present in the email, just that a
% email is present
% We replace any occurence of a URL with 'emailaddr'
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Replace '$' symbols with the word 'dollar'
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== Tokenize Email ===========================

% Output the email to screen as well
fprintf('\n==== Processed Email ====\n\n');

% Process file
l = 0;

while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % (the porterStemmer sometimes has issues, so we use a try catch block)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end

    for i = 1:length(vocabList)
        if strcmp(vocabList(i),str) == 1
            word_indices = [word_indices; i]; 
        end
    end


    % =============================================================

    % Print to screen, ensuring that the output lines are not too long
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;

end

% Print footer
fprintf('\n\n=========================\n');

end
